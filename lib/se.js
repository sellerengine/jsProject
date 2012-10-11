define(["jquery","lib/se.uibase","lib/se.w/widgets"], 
    function($, uiBase, widgets) {
    var se = {};
    se.UiBase = uiBase;
    se.w = widgets;
    //Let this work globally as well
    window.se = se;
    return se;
});
