//function openWorkExperienceModal(element, e) {
//    e.preventDefault();
//    var url = $(element).attr("url");
//    var id = $(element).attr("objectId");
//    var title = $(element).attr("modal_title");
//    $.ajax({
//        type: "GET",
//        url: url,
//        data: {
//            id: id
//        },
//        beforeSend: function (xhr) {
//            $.loader.open({size:32});
//        },
//        dataType: "script",
//        success: function () {
//            $.loader.close(true);
//            $('#workExperienceModal').modal({backdrop: 'static',
//                keyboard: false});
//            $("#workExperienceModalLabel").text(title);
//        },
//        error: function (xhr, status, response) {
//            console.log("AJAX Error: " + status)
//            $.loader.close(true);
//        }
//    });
//};

//function processDeleteWorkExperience(element, e) {
//    e.preventDefault();
//    var url = $(element).attr("url");
//    var id = $(element).attr("objectId");
//    var title = $(element).attr("title");
//    var title_confirm = $(element).attr("title_confirm");
//    var title_msg_confirm = $(element).attr("title_msg_confirm");
//    var title_button_ok = $(element).attr("title_button_ok");
//    var title_button_cancel = $(element).attr("title_button_cancel");
//
//    BootstrapDialog.confirm(title_confirm, title_button_ok, title_button_cancel,title_msg_confirm, function(result){
//        $.loader.open({size:32});
//        if(result) {
//            $.ajax({
//                type: "DELETE",
//                url: url,
//                data: {
//                    id: id
//                },
//                beforeSend: function (xhr) {
//                    $.loader.open({size:32});
//                },
//                dataType: "script",
//                success: function () {
//                    $.loader.close(true);
//                },
//                error: function (xhr, status, response) {
//                    console.log("AJAX Error: " + status)
//                    $.loader.close(true);
//                }
//            });
//        }else {
//            $.loader.close(true);
//        }
//    });
//};