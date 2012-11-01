/**
 CSS loader for require.js; requires jQuery since that's what I know how to use
 * MIT license
 */

/*jslint */
define(['cs'], function (cs) {
    'use strict';
    function getSsModule(name, cssText) {
        //Returns a method that uses jquery to generate javascript text that
        //is the given stylesheet.
        var cssTextNew = cssText.replace(/([\\"'])/g, "\\$1")
            .replace(/\n/g, '\\n')
            ;
        var m = '';
        m += 'define(function() {\n';
        m += '    var cssText = "' + cssTextNew + '";\n';
        m += '    //Create a dynamic stylesheet with the given css text.\n';
        m += '    //Returns a jQuery object around the new stylesheet.\n';
        m += '    //Thanks to http://www.webdeveloper.com/forum/archive/index.php/t-130717.html\n'
        m += '    var pa = document.getElementsByTagName("head")[0];\n'
        m += '    var ss = document.createElement("style");\n'
        m += '    ss.type = "text/css";\n'
        m += '    if (ss.styleSheet) ss.styleSheet.cssText = cssText; //IE\n';
        m += '    else ss.appendChild(document.createTextNode(cssText));\n';
        m += '    pa.appendChild(ss);\n';
        m += '    return ss;\n';
        m += '});\n';
        return m;
    }

    var buildMap = {};

    return {
        version: '0.0.1',

        write: function(pluginName, name, write) {
            if (buildMap.hasOwnProperty(name)) {
                var text = buildMap[name];
                write.asModule(pluginName + "!" + name, text);
            }
        },

        load: function(name, parentRequire, load, config) {
            var path = parentRequire.toUrl(name + '.css');
            //RequireJS optimizes CSS files prior to JS build, so we 
            //automatically will package the optimized result without
            //any more effort.
            cs.fetchText(path, function(text) {
                var module = getSsModule(name, text);
                if (config.isBuild) {
                    buildMap[name] = module;
                }
                load.fromText(name, module);

                //Give result to load... copying cs.js
                parentRequire([name], function(value) {
                    load(value);
                });
            });
        }
    };
});

