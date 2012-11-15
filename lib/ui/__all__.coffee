# Import all of the default UI elements.

# Sorry, but the weird formatting in here is due to coffeescript and requireJS
# being weird together.

define([ 
            "cs!lib/ui/buttonDialog"
            "cs!lib/ui/dialog"
            "cs!lib/ui/dragContainer"
            "cs!lib/ui/listbox"
            "cs!lib/ui/shade"
            "cs!lib/ui/textbox"
            "cs!lib/ui/tooltip" 
        ], (
            ButtonDialog, Dialog, DragContainer, ListBox, Shade, TextBox, 
            Tooltip) ->
    widgets =
        ButtonDialog: ButtonDialog
        Dialog: Dialog
        DragContainer: DragContainer
        ListBox: ListBox
        Shade: Shade
        TextBox: TextBox
        Tooltip: Tooltip
)

