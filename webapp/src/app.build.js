({
    appDir: "../",
    baseUrl: "src/",
    dir: "../../build",
    //Comment out the optimize line if you want
    //the code minified by UglifyJS (or set to "uglify")
    optimize: "uglify",

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
        "coffee-script": "../../../jsProject/lib/cs",
    },

    modules: [
        {
            name: "lib/se"
        },
        {
            name: "loader",
            exclude: [ "jquery", "coffee-script" ]
        }
    ],

    stubModules: [ "cs" ]
})
