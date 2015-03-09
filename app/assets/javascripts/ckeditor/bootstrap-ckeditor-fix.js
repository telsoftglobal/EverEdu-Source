/**
 * Created by sgangji on 6/23/2014.
 */
// bootstrap-ckeditor-fix.js
// hack to fix ckeditor/bootstrap compatiability bug when ckeditor appears in a bootstrap modal dialog
//
// Include this file AFTER both jQuery and bootstrap are loaded.
$.fn.modal.Constructor.prototype.enforceFocus = function() {
    modal_this = this

    $("#updateModal").on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
            modal_this.$element.focus()
        }
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
            && $(e.target.parentNode).hasClass('cke_contents cke_reset')) {
            modal_this.$element.focus()
        }
    })

//    $(document).on('focusin.modal', function (e) {
//        //console.log("Is target not modal window "+ (modal_this.$element[0] !== e.target));
//        //console.log("Is target not child of modal window "+ (!modal_this.$element.has(e.target).length));
//        //console.log("Is target parent has class "+ ($(e.target.parentNode).hasClass('cke_contents cke_reset')));
//// Fix for CKEditor + Bootstrap IE issue with dropdowns on the toolbar
//// Adding additional condition '$(e.target.parentNode).hasClass('cke_contents cke_reset')' to
//// avoid setting focus back on the modal window.
//        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
//            && $(e.target.parentNode).hasClass('cke_contents cke_reset')) {
//            modal_this.$element.focus()
//        }
//    })
};