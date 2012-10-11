
import cherrypy
import os

from main import MainRoot, StaticServer, _DIR

if __name__ == '__main__':
    root = MainRoot()
    # Disable caching for development
    root._cp_config = { 'response.headers.Cache-Control': 'No-Cache' }
    # Add the lib dir
    root.lib = StaticServer(_DIR + '/../jsProject/lib')
    cherrypy.tree.mount(root, '/')
    cherrypy.engine.start()
    cherrypy.engine.block()

