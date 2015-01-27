/**
 * Created by hapt on 01/12/2014.
 */


$(document).on('change', '#category_option', function(evt) {
    $.ajax('/roadmap/update_levels', {
        type: 'GET',
        dataType: 'script',
        data: {
            category_id: $("#category_option option:selected").val()
        },
        beforeSend: function (xhr) {

            $.loader.open({imgUrl: "<%= asset_path('assets/template/ajaxloader/images/loading32x32.gif') %>"});
//                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        error: function (jqXHR, textStatus, errorThrown) {

            console.log("AJAX Error: " + textStatus);
        },
        success: function (data, textStatus, jqXHR) {
            console.log("AJAX Error: " + textStatus);
            $.loader.close();
        }
    });
    });