reqs = ["cs!lib/ui.base", "cs!lib/ui/shade", "css!lib/ui/dialog"]
module = (UiBase, Shade) ->
    class Dialog extends UiBase
        ### A Dialog that adds to the end of the body and shades itself
        immediately.
        
        == options ==
        body: The DOM to use as the body.
        width: The width of the dialog, in px
        height: The height of the dialog, in px
        ###
        
        constructor: (options) ->
            @options = options
            
            super('<div class="ui-dialog"></div>')
            ww = $(window).width()
            wh = $(window).height()
            wl = $(window).scrollLeft()
            wt = $(window).scrollTop()
            dw = $(document).width()
            dh = $(document).height()

            if @options.body?
                @append(@options.body)
                
            preAddCss = {}
            if @options.width?
                preAddCss.width = @options.width + 'px'
            if @options.height?
                preAddCss.height = @options.height + 'px'
            @css(preAddCss)
            
            @appendTo('body')
            
            # Find upper-left corner
            dialogX = Math.max(0, ww * 0.5 - @outerWidth())
            dialogY = Math.max(0, wt + wh * 0.5 - @outerHeight())
            
            @css
                position: 'absolute'
                left: wl + dialogX + 'px'
                top: wt + dialogY + 'px'
                width: @options.width + 'px'
                height: @options.height + 'px'
                
            Shade.show(@, hide: () => @remove())
                
define(reqs, module)
        