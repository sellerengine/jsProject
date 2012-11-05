define ["css!lib/reset", "css!main", "cs!lib/ui"], () ->
    $ () ->
        box = new ui.ListBox()
        box.addOption "dog", "I want a puppy!"
        box.addOption "cat", "I want a kitty cat!"
        box.change () ->
            $('body').append('<div>Awww, you want a ' + box.val() + '</div>')
        $('body').append box
        $.get(
            '/json'
            (data) ->
                $('body').append('<div>Json result: ' + data.result + '</div>')
        )

