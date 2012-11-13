define [ "cs!lib/ui.base" ], (UiBase) ->
    class DragContainer extends UiBase
        ### A container that allows dragging elements either via a handle
        (specified through the option "handleSelector") or the whole object.
        All styling is dependent on client.
        ###

        constructor: (options) ->
            @options = options
            super(@options.root)

            @bind "mousedown", (e) =>
                return @_onMouseDown(e)


        startDrag: (child, x, y) ->
            ### Start drag of element child (jQuery object) at position x,y 
            (that's pageX and pageY)
            ###
            @_dragElement = child
            @_dragLastSwap = null
            @_dragStart = 
                x: x
                y: y
            $(document).bind(
                "mousemove.dragContainer mouseup.dragContainer"
                (e) => @_onDrag(e)
            )

            @_oldDragElementCss =
                opacity: child.css('opacity')
            child.css
                opacity: 0.4


        _onDrag: (e) ->
            if e.type == "mouseup"
                # Finish our drag by restoring the old style and unbinding
                # our events
                @_dragElement.css(@_oldDragElementCss)
                $(document).unbind("mousemove.dragContainer")
                $(document).unbind("mouseup.dragContainer")
            else if e.type == "mousemove"
                # See if we have a new position
                cursor =
                    x: e.pageX
                    y: e.pageY
                for c in @children()
                    # Can we even drag here?
                    if @options.handleSelector?
                        if $(@options.handleSelector, c).length == 0
                            continue

                    $c = $(c)
                    offset = $c.offset()
                    b =
                        left: offset.left
                        top: offset.top
                        right: offset.left + $c.outerWidth(true)
                        bottom: offset.top + $c.outerHeight(true)
                    if b.left <= cursor.x and cursor.x <= b.right
                        if b.top <= cursor.y and cursor.y <= b.bottom
                            if c == @_dragElement[0]
                                # Clear out @_dragLastSwap, since we're over
                                # ourselves, meaning we won't see any "jitter"
                                @_dragLastSwap = null
                                return false
                            else if @_dragLastSwap and @_dragLastSwap[0] == c
                                # We would jitter if we swapped with this,
                                # since the cursor hasn't gotten back to
                                # the element being dragged.  Ignore.
                                return false

                            # REPLACE!
                            ci = $c.index()
                            di = @_dragElement.index()
                            if ci < di
                                @_dragElement.detach().insertBefore($c)
                            else
                                @_dragElement.detach().insertAfter($c)
                            @_dragLastSwap = $c
                            break


        _onMouseDown: (e) ->
            # Find which child, if any, the event was over
            child = $(e.target)
            pathToTarget = []
            while child.length != 0
                next = child.parent()
                # If the next parent is us, then child is right
                if next[0] == @[0]
                    break
                pathToTarget.push(child[0])
                child = next
            if child.length == 0
                # Nothing found, who cares
                return

            # Do we have a specific handle?
            if @options.handleSelector?
                handle = $(@options.handleSelector, child)
                if handle.length == 0
                    # No handle on this child, skip
                    return

                if $.inArray(handle[0], pathToTarget) < 0
                    # Not on the handle, skip
                    return

            # We are dragging, bind our event handlers
            @startDrag(child, e.pageX, e.pageY)
            # Cancel default events (e.g selection)
            return false


    return DragContainer

