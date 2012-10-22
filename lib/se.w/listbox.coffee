define(
    [ "cs!lib/se.uibase" ]
    (UiBase) ->
        class ListBox extends UiBase
            constructor: () ->
                super $('<select></select>')

            addOption: (value, label = value) ->
                opt = $('<option></option>');
                opt.val(value).text(label)
                this.append(opt)
)

