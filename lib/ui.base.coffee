define(
    [ "jquery", "css!lib/ui.base" ]
    () ->
        class UiBase extends $
            constructor: (root, options = {}) ->
                ### Make a new UiBase object based around the given dom element
            	or string.  If root is a string, it will be turned into a 
            	set of dom elements via jQuery.
            	
            	options:
            		noSelect: if true, prevent this object from starting or 
            		      being part of a selection.
                ###
                if typeof root == 'string'
                    root = $(root)
                this.length = 1
                this[0] = root[0]
                this._root = root
                this._root.addClass("ui-base")
                this._root.data("ui-base", this)
                
                # No select?
                if options.noSelect
                    this.addClass('ui-base-noselect')
                    this.bind('mousedown', (e) -> e.preventDefault())

                # jQuery uses the "constructor" method, so re-assign it on
                # our instance
                this.constructor = $.fn.constructor
                
            
            uiClosest: () ->
                ### Override jQuery.closest to return a UiBase element.  
                Prefixed with ui to distinguish.
                ###
                return UiBase.fromDom(@closest.apply(@, arguments))


        UiBase.fromDom = (dom) ->
            if dom instanceof UiBase
                return dom
            else if typeof dom == 'string'
                dom = $(dom)
            else if dom not instanceof $
                dom = $([dom])
            return dom.data('ui-base') || null

        cmDiv = $(
            '<div style="display:inline-block;width:1cm;height:1cm;"></div>');
        cmDiv.appendTo('body');
        UiBase.pixelsPerCm = cmDiv.width()
        cmDiv.remove();

        return UiBase
)
