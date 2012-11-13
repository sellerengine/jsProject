define ["cs!lib/ui/dialog"], (Dialog) ->
    class ButtonDialog extends Dialog
        constructor: (options) ->
            @options = $.extend({}, options)
            body = $('<div class="ui-button-dialog"></div>')
            body.text(@options.prompt or '(no prompt)')
            
            buttonDiv = $('<div class="ui-button-dialog-buttons"></div>')
                .appendTo(body)
            for btn of @options.buttons
                callback = ((btn) =>
                    btnCallback = @options.buttons[btn]
                    () =>
                        if btnCallback?
                            btnCallback()
                        @remove()
                        return false
                )(btn)
                button = $('<input type="submit" />')
                    .val(btn)
                    .bind("click", callback)
                    .appendTo(buttonDiv)
            
            @options.body = body
            super(@options)
    