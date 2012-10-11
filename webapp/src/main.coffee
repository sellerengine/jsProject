
require ["lib/se"], () ->
    $ () ->
        box = new se.w.ListBox()
        box.addOption "dog", "I want a puppy!"
        box.addOption "cat", "I want a kitty cat!"
        box.change () ->
            $('body').append('<div>Awww, you want a ' + box.val() + '</div>')
        $('body').append box

