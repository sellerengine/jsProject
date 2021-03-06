
define(["jquery", "cs!lib/zeroTimeout", "cs!lib/ui.base", 
        "cs!lib/ui/__all__"], ($, zeroTimeout, uiBase, uiWidgets) ->
    ui = 
        Base: uiBase
        fromDom: uiBase.fromDom
        setZeroTimeout: zeroTimeout.setZeroTimeout
        clearZeroTimeout: zeroTimeout.clearZeroTimeout
    for widget of uiWidgets
        ui[widget] = uiWidgets[widget]
    window.ui = ui
)
