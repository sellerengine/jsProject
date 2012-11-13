define ["cs!lib/ui.base", "css!lib/ui/shade"], (UiBase) ->
    # Z-index for next shade
    shades = []
    class ShadeOverlay extends UiBase
        constructor: (el, options) ->
            if not (el instanceof $)
                el = $(el)
            @element = el
            @options = options
            super('<div class="ui-shade"></div>')
            @insertBefore(el)
            @_elementZindex = @element.css('z-index')
            @element.css('z-index', 100 + shades.length)

            @bind("click", () =>
                @hide()
            )
            
            @_interval = setInterval(
                () => @_checkElement()
                100
            )
            
            shades.push(@)


        hide: () ->
            clearInterval(@_interval)
            if @options.hide
                @options.hide()
            @remove()
            
            for q, i in shades
                if q == @
                    shades.splice(i, 1)
                    break


        _checkElement: () ->
            if not @element.is(':visible')
                @hide()


    Shade =
        hide: () ->
            # Hide the top shade
            shades[shades.length - 1].hide()
            
        show: (el, options) ->
            new ShadeOverlay(el, options)

