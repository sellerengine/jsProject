#! /usr/bin/python

import optparse
import os
import shutil
import sys

_DIR = os.path.dirname(os.path.abspath(__file__))

def safeRemove(path):
    try:
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            os.remove(path)
    except OSError:
        pass

if __name__ == '__main__':
    parser = optparse.OptionParser()
    parser.prog = sys.argv[0]
    parser.usage = """====== forkJsProject.py ======
Forks a new jsProject with the given name.

Usage:
    forkJsProject.py {new project name}

Will be created in sibling directory.
"""
    values = parser.parse_args(args = sys.argv[1:])
    if len(values[1]) < 1:
        print(parser.usage)
        sys.exit(1)
    projectName = values[1][0]

    if os.path.exists(projectName):
        raise ValueError("Project already exists?")
    if _DIR == os.getcwd():
        projectName = '../' + projectName
    shutil.copytree(_DIR, projectName)
    safeRemove(os.path.join(projectName, 'build'))
    safeRemove(os.path.join(projectName, 'lib'))
    safeRemove(os.path.join(projectName, 'r.js'))
    safeRemove(os.path.join(projectName, 'forkJsProject.py'))
    safeRemove(os.path.join(projectName, '.git'))
    safeRemove(os.path.join(projectName, 'README'))

