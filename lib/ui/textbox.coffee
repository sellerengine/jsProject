define([
            "cs!lib/ui.base", "cs!lib/zeroTimeout", "css!lib/ui/textbox"
        ], (
            UiBase, ZeroTimeout) ->
    class TextBox extends UiBase
        constructor: (options) ->
            @options = $.extend(
                {
                    expand: false
                    expandPad: 30 # pixels beyond actual content
                    multiline: false
                    minWidth: 40
                    maxWidth: null
                }
                options
            )
            if @options.multiline
                super('<textarea></textarea>')
            else
                super('<input type="text" />')
            
            # After we've been added to dom, adjust size for first time
            # and do bindings
            ZeroTimeout.setZeroTimeout () =>
                if @options.expand
                    if @options.multiline
                        # Expand vertically
                        @bind("keyup change", () => @_expandVertical())
                        @_expandVertical()
                    else
                        # Expand horizontally
                        @bind("keyup change", () => @_expandHorizontal())
                        @_expandHorizontal()
                    
                    
        _expandHorizontal: () ->
            ### Re-calculate width according to content + expandPad
            ###
            tester = @_getTester()
            w = tester.width() + @options.expandPad
            tester.remove()
            
            w = Math.max(w, @options.minWidth)
            if @options.maxWidth?
                w = Math.min(w, @options.maxWidth)
            @width(w)
            
            
        _expandVertical: () ->
            ### Re-calculate width & height according to content
            ###
            tester = @_getTester()
            w = tester.width() + @options.expandPad
            w = Math.max(w, @options.minWidth)
            if @options.maxWidth?
                w = Math.min(w, @options.maxWidth)
            tester.remove()
            
            # We have our width, our height comes from scrollHeight
            @width(w)
            @height(1)
            h = @[0].scrollHeight
            @height(h)
                
                
        _getTester: () ->
            ### Return an element that mocks the same text attributes of 
            ourselves and can be used for measurements.
            
            Defaults to white-space: nowrap, e.g. single line.  Must be
            removed after use.
            ###
            tester = $('<span class="ui-textbox-tester"></span>')
                .text(@val())
                .css
                    fontSize: @css('fontSize')
                    fontFamily: @css('fontFamily')
                    fontWeight: @css('fontWeight')
                    letterSpacing: @css('letterSpacing')
                    whiteSpace: 'nowrap'
            tester.insertAfter(@)
            return tester
)
        