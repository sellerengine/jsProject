define(
    [ "jquery", "cs!lib/se.uibase", "cs!lib/se.w/widgets" ]
    ($, uiBase, widgets) ->
        se = 
            UiBase: uiBase
            w: widgets
        window.se = se
        se
)

