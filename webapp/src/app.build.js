({
    appDir: "../",
    baseUrl: "src/",
    dir: "../../build",
    //Comment out the optimize line if you want
    //the code minified by UglifyJS (or set to "uglify")
    optimize: "none",

    //onBuildWrite: function(moduleName, path, contents) {
    //    //Ensure that we replace cs! dependencies with plain dependencies.
    //    return contents.replace(/"cs!/g, '"');
    //},

    shim: {
        'jquery': {
            deps: [],
            exports: '$'
        }
    },

    paths: {
        "jquery": "../../../jsProject/lib/jquery-1.8.2.min",
        "lib": "../../../jsProject/lib",
        "cs": "../../../jsProject/lib/cs",
        "coffee-script": "../../../jsProject/lib/coffee-script",
    },

    modules: [
        {
            name: "loader"
        }
    ],

    stubModules: [ "coffee-script", "cs", "loader" ]
})
