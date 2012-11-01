define(
    [ "jquery", "cs!lib/ui.base", "cs!lib/ui/__all__" ]
    ($, uiBase, uiWidgets) ->
        ui = 
            Base: uiBase
            fromDom: uiBase.fromDom
        for widget of uiWidgets
            ui[widget] = uiWidgets[widget]
        window.ui = ui
)

