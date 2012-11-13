define ["cs!lib/ui.base", "css!lib/ui/shade"], (UiBase) ->
    # Z-index for next shade
    shadeZ = 100
    class ShadeOverlay extends UiBase
        constructor: (el, options) ->
            if not (el instanceof $)
                el = $(el)
            @element = el
            @options = options
            super('<div class="ui-shade"></div>')
            @insertBefore(el)
            @_elementZindex = @element.css('z-index')
            @element.css('z-index', shadeZ++)

            @bind("click", () =>
                @hide()
            )
            
            @_interval = setInterval(
                () => @_checkElement()
                100
            )


        hide: () ->
            clearInterval(@_interval)
            if @options.hide
                @options.hide()
            @remove()
            shadeZ--


        _checkElement: () ->
            if not @element.is(':visible')
                @hide()


    Shade =
        show: (el, options) ->
            new ShadeOverlay(el, options)

