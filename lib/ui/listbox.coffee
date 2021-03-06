define(
    [ "cs!lib/ui.base" ]
    (UiBase) ->
        class ListBox extends UiBase
            constructor: (@options = {}) ->
                super $('<select></select>')
                if @options.multiple
                    this.attr('multiple', 'multiple')
                    
                @reset()

            addOption: (value, label = value) ->
                opt = $('<option></option>');
                opt.val(value).text(label)
                this.append(opt)
                if @_isFirst
                    @_isFirst = false
                    this.trigger('change')
                else if @options.sorted
                    newOrder = this.children('option').sort (a, b) ->
                        at = $(a).text().toLocaleLowerCase()
                        bt = $(b).text().toLocaleLowerCase()
                        return if at > bt then 1 else -1
                    this.empty().append(newOrder)
                    
                    
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
                @_isFirst = true


            select: (value) ->
                this.val(value).trigger('change')
)

