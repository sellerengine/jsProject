define(["cs!lib/ui.base", "cs!lib/ui/shade", 
        "css!lib/ui/dialog"], (UiBase, Shade) ->
    class Dialog extends UiBase
        ### A Dialog that adds to the end of the body and shades itself
        immediately.
        
        == options ==
        body: The DOM to use as the body.
        width: The width of the dialog, in px
        height: The height of the dialog, in px
        ###
        
        constructor: (options) ->
            @dlgOptions = options
            
            super('<div class="jspui-dialog"></div>')
            ww = $(window).width()
            wh = $(window).height()
            wl = $(window).scrollLeft()
            wt = $(window).scrollTop()
            dw = $(document).width()
            dh = $(document).height()

            if @dlgOptions.body?
                @append(@dlgOptions.body)
                
            preAddCss = {}
            if @dlgOptions.width?
                preAddCss.width = @dlgOptions.width + 'px'
            if @dlgOptions.height?
                preAddCss.height = @dlgOptions.height + 'px'
            @css(preAddCss)
            
            @appendTo('body')
            
            # Find upper-left corner
            dialogX = Math.max(0, ww * 0.5 - @outerWidth())
            dialogY = Math.max(0, wt + wh * 0.5 - @outerHeight())
            
            @css
                position: 'absolute'
                left: wl + dialogX + 'px'
                top: wt + dialogY + 'px'
                width: @dlgOptions.width + 'px'
                height: @dlgOptions.height + 'px'
                
            Shade.show(@, hide: () => @remove())
)
