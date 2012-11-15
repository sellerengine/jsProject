define ["cs!lib/ui/dialog"], (Dialog) ->
    class ButtonDialog extends Dialog
        constructor: (options) ->
            @dlgOptions = $.extend({}, options)
            body = $('<div class="ui-button-dialog"></div>')
            body.text(@dlgOptions.prompt or '(no prompt)')
            
            buttonDiv = $('<div class="ui-button-dialog-buttons"></div>')
                .appendTo(body)
            for btn of @dlgOptions.buttons
                callback = ((btn) =>
                    btnCallback = @dlgOptions.buttons[btn]
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
            
            @dlgOptions.body = body
            super(@dlgOptions)
    