
//NOTE: This config must be duplicated in app.build.js...
requirejs.config({
    shim: {
        'jquery': {
            deps: [],
            exports: '$'
        },
        'jquery.ui': {
        	deps: ['jquery','css!jquery.ui.theme/jquery-ui-custom'],
        	exports: '$.ui'
        }
    }
    , paths: {
        'cs': '../lib/cs',
        'css': '../lib/css',
        'coffee-script': '../lib/coffee-script',
        'jquery': '../lib/jquery-1.8.2.min',
        "jquery.ui": "../lib/plugins/jquery.ui/jquery-ui-1.9.1.min",
        'lib': '../lib'
    }
});

require(["cs!main"], function() {
    //Just load up main now that we've configured paths
});

