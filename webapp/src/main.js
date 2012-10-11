
//NOTE: This config must be duplicated in app.build.js...
requirejs.config({
    shim: {
        'jquery': {
            deps: [],
            exports: '$'
        }
    }
    , paths: {
        'jquery': '../lib/jquery-1.8.2.min',
        'lib': '../lib',
    }
});

require(["lib/se"], function() {
    //the jquery.alpha.js and jquery.beta.js plugins have been loaded.
    $(function() {
        var box = new se.w.ListBox();
        box.addOption("dog", "I want a puppy!");
        box.addOption("cat", "I want a kitty cat!");
        box.change(function() {
            $('body').append('<div>Awww, you want a ' + box.val() + '</div>');
        });
        $('body').append(box);
    });
});
