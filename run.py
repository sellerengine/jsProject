#! /usr/bin/python

"""
Build and/or run the project.

Example usage:

./run.py (Runs in development mode)
./run.py --build (Compiles and runs the compiled code)
./run.py --build-only (Compiles only, and exits)
"""

import cherrypy
import os
import shutil
import subprocess
import sys

from server.main import MainRoot, StaticServer, _DIR

def getLatestSource():
    """Return the latest timestamp for files that go into the source of this
    project.
    """
    sourceTrees = [ 'webapp', '../jsProject/lib' ]

    latest = 0
    for sourceDir in sourceTrees:
        sourceDir = os.path.join(_DIR, sourceDir)
        for dir, subdirs, files in os.walk(sourceDir):
            for f in files:
                fpath = os.path.join(sourceDir, f)
                if os.path.isfile(fpath):
                    latest = max(latest, os.path.getmtime(fpath))

    return latest


def tryBuild():
    """See if we need to do a build (there is a source file more recent than
    the latest build), and build if we do.
    """
    buildDate = 0
    buildDir = os.path.join(_DIR, 'build')
    buildDateFile = os.path.join(_DIR, 'build/.buildtime')
    if os.path.isfile(buildDateFile):
        buildDate = os.path.getmtime(buildDateFile)

    latestUpdate = getLatestSource()
    if buildDate >= latestUpdate:
        # No build needed
        return False

    # Do the build in a secondary build folder, so that if the build fails
    # we don't mess up the last build (in case a process is still running)
    tempBuild = os.path.join(_DIR, "build.new")
    # Didn't exist
    try:
        shutil.rmtree(tempBuild)
    except OSError:
        pass

    os.mkdir(tempBuild)

    # Touch the buildtime file to set the time our build was started
    open(os.path.join(tempBuild, '.buildtime'), 'w').close()

    # Run node to do the compile
    r = subprocess.call("node ../jsProject/r.js -o webapp/app.build.js",
            shell = True, cwd = _DIR)
    if r != 0:
        raise ValueError("node compile failed: " + str(result))

    # Remove the build summary from node
    os.remove(os.path.join(tempBuild, 'build.txt'))

    # Copy require.js over to the new project
    shutil.copyfile(os.path.join(_DIR, '../jsProject/lib/require.js'),
            os.path.join(tempBuild, 'require.js'))

    # Remove *.coffee and *.css files, as they have been compiled in
    for dir, subdirs, files in os.walk(tempBuild):
        for f in files:
            if f.endswith('.css') or f.endswith('.coffee'):
                os.remove(os.path.join(tempBuild, f))

    # OK, now we just need to unlink the old build and replace it
    shutil.rmtree(buildDir)
    os.rename(tempBuild, buildDir)

    # Build success
    return True


if __name__ == '__main__':
    root = MainRoot()

    # Disable caching - if we don't, then between built and development
    # versions the web browser won't re-send requests.  Note that we could
    # also come up with a scheme where the URL changes when the version
    # changes.
    root._cp_config = { 'response.headers.Cache-Control': 'No-Cache' }

    # Support a cherrypy.ini file, as well as a cherrypy_local.ini for 
    # configuration of this specific app
    baseConfig = os.path.join(_DIR, 'cherrypy.ini')
    if os.path.isfile(baseConfig):
        cherrypy.config.update(baseConfig)
    otherConfig = os.path.join(_DIR, 'cherrypy_local.ini')
    if os.path.isfile(otherConfig):
        cherrypy.config.update(otherConfig)

    if '--build-only' in sys.argv:
        if not tryBuild():
            print("Up to date")
        sys.exit(0)

    if '--build' in sys.argv:
        # Running compiled version, redirect src to built version
        cherrypy.log("Using build/ rather than webapp/")
        root.src = StaticServer(_DIR + '/build')

        # Do we need to compile?
        if not tryBuild():
            cherrypy.log("Build skipped - up to date")
    else:
        # Add the lib dir, rewrite src/require.js to lib/require.js
        root.lib = StaticServer(_DIR + '/../jsProject/lib')
        def serveRequire():
            return cherrypy.lib.static.serve_file(
                    root.lib._path + '/require.js')
        cherrypy.expose(serveRequire)
        root.src.require_js = serveRequire
    cherrypy.tree.mount(root, '/')
    cherrypy.engine.start()
    cherrypy.engine.block()

