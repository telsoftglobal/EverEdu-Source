// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require template/library/jquery/jquery.min.js
//= require template/library/jquery/jquery-migrate.min.js
//= require template/library/bootstrap/js/bootstrap.js
//= #require template/library/bootstrap/bootstrap.min
//= #require template/library/bootstrap/js/bootstrap.min.js
//= require template/library/modernizr/modernizr.js
//= #require template/plugins/core_less-js/less.min.js

//= #require template/plugins/core_browser/ie/ie.prototype.polyfill.js
//= require template/plugins/forms_wizards/jquery.bootstrap.wizard
//= #require template/plugins/forms_elements_bootstrap-datepicker/js/bootstrap-datepicker
//= require template/plugins/forms_validator/jquery-validation/dist/jquery.validate.min
//= require template/plugins/forms_elements_bootstrap-datepicker/js/bootstrap-datepicker
//= require template/plugins/forms_elements_inputmask/jquery.inputmask.bundle.min
//= require template/plugins/notifications_notyfy/js/jquery.notyfy
//= #require template/components/admin_notifications_notyfy/notyfy.init

//= require template/plugins/notifications_gritter/js/jquery.gritter.min
//= #require template/components/admin_notifications_gritter/gritter.init

//= require template/ztree/jquery.ztree.all-3.5.min


//= require template/selectr/selectr
//= require template/summernote/summernote
//= require template/bootstrap3-dialog/bootstrap-dialog
//= require template/bootbox/purl
//= require template/ajaxloader/jquery-loader
//= #require template/plugins/forms_editors_wysihtml5/js/wysihtml5-0.3.0_rc2.min
//= #require template/plugins/forms_editors_wysihtml5/js/bootstrap-wysihtml5-0.0.2.js

//= require template/slidebar/slidebars.min
//= require jquery_ujs
//= require turbolinks
//= #require search
//= require highcharts
//= require exporting-highchart
//= require comments.js
//= require seemore.js
//= require work_experiences.js
//= require validator.js
//=require template/library/jquery-ui/js/jquery-ui.min
//=# require show_for_student
//= require ckeditor/bootstrap-ckeditor-fix
//=# require ckeditor/plugin/maxlength
//= require ckeditor/init.js.erb
//= require_self

$.validator.setDefaults(
    {
        showErrors: function(map, list)
        {
            this.currentElements.parents('label:first, div:first').find('.has-error').remove();
            this.currentElements.parents('.form-group:first').removeClass('has-error');
            this.currentElements.parent().removeClass('has-error');

            $.each(list, function(index, error)
            {
                var ee = $(error.element);
                console.log(ee.parents('label:first'));
                var eep = ee.parents('label:first').length ? ee.parents('label:first') : ee.parents('div:first');
                //'.form-group:first'
                ee.closest(".form-group").addClass('has-error');
                eep.find('.has-error').remove();
                eep.append('<p class="has-error help-block">' + error.message + '</p>');
            });
            $.loader.close(true);
            //refreshScrollers();

        }
    });

