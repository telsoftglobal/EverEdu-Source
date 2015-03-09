function bindSubmitReplyForm() {
    $("#comments-list").find("form.new-reply").each(function (index) {
        $(this).off("submit");
        $(this).on("submit", function (e) {
            e.preventDefault();
            var that = this;
            $.ajax({
                type: "POST",
                url: "/comments/reply",
                data: {
                    commentable_id: $(this).find('#commentable_id').val(),
                    commentable_type: $(this).find('#commentable_type').val(),
                    comment: $(this).find("#comment").val(),
                    parent_id: $(this).find("#parent_id").val()
                },
                success: function (data) {
                },
                error: function (xhr, status, response) {
                    console.log("AJAX Error: " + status)
                }
            });
        });
    });
};