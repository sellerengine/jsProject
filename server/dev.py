
import cherrypy
import os
import sys

from main import MainRoot, StaticServer, _DIR

if __name__ == '__main__':
    root = MainRoot()
    # Disable caching for development
    root._cp_config = { 'response.headers.Cache-Control': 'No-Cache' }
    if '--built' in sys.argv:
        # Running compiled version, redirect src to built version
        cherrypy.log("Using build/ rather than webapp/")
        root.src = StaticServer(_DIR + '/build/src')
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

