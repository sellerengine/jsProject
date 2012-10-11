define(["lib/se.uibase"], function(UiBase) {
    //Basic ListBox
    var ListBox = UiBase.extend({
        init: function() {
            this._super($('<select></select>'));
        }
        ,
        addOption: function(value, label) {
            if (label == undefined) {
                label = value;
            }
            var opt = $('<option></option>');
            opt.val(value).text(label);
            this.append(opt);
        }
    });
    return ListBox;
});
