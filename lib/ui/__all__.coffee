reqs = [ 
    "cs!lib/ui/dragContainer"
    "cs!lib/ui/listbox"
    "cs!lib/ui/shade"
    "cs!lib/ui/tooltip" 
]
module = (DragContainer, ListBox, Shade, Tooltip) ->
    widgets =
        DragContainer: DragContainer
        ListBox: ListBox
        Shade: Shade
        Tooltip: Tooltip

define(reqs, module)

