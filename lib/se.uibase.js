define(["lib/class"], function(Class) {
    var UiBase = $.extend(
        Class.extend.call(
            $
            , {
            init: function(root) {
              root = root.domroot || root;
              this.length = 1;
              this[0] = root[0];
              this._root = root;
              this._root.addClass('sc-ui-base');
              this._root.data('ui-base', this);
            }
            , 
            onWindowResize: function() {
              //Called when the window is resized; do any ui resizing
              //that needs to happen.  Here so that widgets don't have to
              //register resize.
            }
        })
        , { 
            fromDom: function(dom) {
              if (dom instanceof UiBase) {
                return dom;
              }
              else if (!(dom instanceof $)) {
                dom = $([dom]);
              }
              return dom.data('ui-base') || null;
            }
            , remove: function(domElement) {
                //Removes the specified domElement, calling remove() in the
                //context of the se.UiBase extension if it is helpful to do so.
                if (!(domElement instanceof UiBase)) {
                    var ui = UiBase.fromDom(domElement);
                    if (ui !== null) {
                        domElement = ui;
                    }
                }  
                domElement.remove();
            }
        }
    );
    
    return UiBase;
});
