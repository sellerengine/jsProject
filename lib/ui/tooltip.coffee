define [ "cs!lib/ui.base", "css!lib/ui/tooltip" ], (UiBase) ->
    # Movement threshold to hide tooltip instead of fade
    moveTolerance = 2 * UiBase.pixelsPerCm

    # Keep the current tooltip in a pointer
    curTip = $()

    class TooltipWidget extends UiBase
        constructor: (options) ->
            # options - left, top, html, preferLeft
            curTip = @
            @options = options
            super('<div class="jspui-tooltip"></div>')
            @html(options.html)
            @css
                # Note - we have to add an offset to X so that mouse movement
                # doesn't go on us again
                left: options.left + 10 + 'px'
                top: options.top + 'px'
            @appendTo('body')

            mw = @outerWidth(true)
            mh = @outerHeight(true)
            pos = @offset()
            # Box the window
            wl = $(window).scrollLeft()
            wr = wl + $(window).width()
            wt = $(window).scrollTop()
            wb = wt + $(window).height()
            @isLeft = false

            if options.preferLeft and options.left - 10 - mw >= wl
                # We shouldn't be wrapping
                @css('left', '')
                @css('right', wr - (options.left - 10) + 'px')
                @isLeft = true
            else if pos.left + mw >= wr
                @css('left', '')
                @css('right', wr - (options.left - 10) + 'px')
                @isLeft = true

            # Moving left/right when we're off the right side can change 
            # our width, which changes our height
            mh = @outerHeight(true)
            if pos.top + mh >= wb
                # Don't go above the top of the window though
                sh = wt
                @css('top', Math.max(sh, options.top - mh) + 'px')


        remove: (newX, newY) ->
            doFade = true
            if newX?
                # There is a newX, we might want to not fade
                myOffset = @offset()
                myRight = myOffset.left + @outerWidth(true)
                myBottom = myOffset.top + @outerHeight(true)
                xIsOk = false
                yIsOk = false
                tol = moveTolerance
                if newX <= myRight and myOffset.left <= newX
                    xIsOk = true
                else if newX < myRight and myOffset.left - newX < tol
                    xIsOk = true
                else if myOffset.left < newX and newX - myRight < tol
                    xIsOk = true

                if xIsOk
                    if newY <= myBottom and myOffset.top <= newY
                        yIsOk = true
                    else if newY <= myBottom and myOffset.top - newY < tol
                        yIsOk = true
                    else if myOffset.top < newY and newY - myBottom < tol
                        yIsOk = true

                if xIsOk and yIsOk
                    doFade = false

            if not doFade
                super()
            else
                @animate({ 'opacity': 0 }, 300, null, () =>
                    super()
                )


    Tooltip =
        show: (event, html) ->
            ### Show a tooltip and return the new tooltip object
            ###
            # Take away the old, add the new
            curTip.remove(event.pageX, event.pageY)

            # Do we want to be on the left?
            preferLeft = false
            if curTip.options
                if event.pageX > curTip.options.left or
                        event.pageX == curTip.options.left and curTip.isLeft
                    preferLeft = true

            # Assigns curTip on its own, in case of error
            return new TooltipWidget(
                left: event.pageX
                top: event.pageY
                html: html
                preferLeft: preferLeft
            )

        hide: () ->
            ### Hide the current tooltip object; call TooltipWidget.remove()
            to remove a specific one.
            ###
            curTip.remove()

