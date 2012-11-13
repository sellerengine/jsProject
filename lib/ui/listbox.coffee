define(
    [ "cs!lib/ui.base" ]
    (UiBase) ->
        class ListBox extends UiBase
            constructor: (options = {}) ->
                super $('<select></select>')
                if options.multiple
                    this.attr('multiple', 'multiple')

            addOption: (value, label = value) ->
                opt = $('<option></option>');
                opt.val(value).text(label)
                this.append(opt)
                if this.children().length == 1
                    this.trigger('change')
                    
                    
            remove: (val, newVal) ->
                ### Remove the specified value from our options
                ###
                wasSelected = (@val() == val)
                
                for opt in @children()
                    if $(opt).val() == val
                        $(opt).remove()
                
                if wasSelected
                    if newVal?
                        @select(newVal)
                    else
                        @trigger('change')


            reset: () ->
                this.empty()


            select: (value) ->
                this.val(value).trigger('change')
)

