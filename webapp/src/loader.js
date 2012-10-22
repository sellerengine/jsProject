
//NOTE: This config must be duplicated in app.build.js...
requirejs.config({
    shim: {
        'jquery': {
            deps: [],
            exports: '$'
        }
    }
    , paths: {
        'cs': '../lib/cs',
        'coffee-script': '../lib/coffee-script',
        'jquery': '../lib/jquery-1.8.2.min',
        'lib': '../lib'
    }
    , stubModules: [ "coffee-script", "cs" ]
});

require(["cs!main"], function() {
    //Just load up main now that we've configured paths
});

