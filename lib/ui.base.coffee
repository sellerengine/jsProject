define(
    [ "jquery" ]
    () ->
        class UiBase extends $
            constructor: (root) ->
                if typeof root == 'string'
                    root = $(root)
                this.length = 1
                this[0] = root[0]
                this._root = root
                this._root.addClass("ui-base")
                this._root.data("ui-base", this)

        UiBase.fromDom = (dom) ->
            if dom instanceof UiBase
                return dom
            else if dom not instanceof $
                dom = $([dom])
            return dom.data('ui-base') || null

        return UiBase
)
