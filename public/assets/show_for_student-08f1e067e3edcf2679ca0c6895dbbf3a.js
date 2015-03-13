(function() {
  $(function() {
    return $(document).on('click', '#divRight a', function(evt) {
      $('#divRight a').removeClass("strong");
      $(this).addClass("strong");
      return $.ajax('/student/update_curriculum_detail', {
        type: 'GET',
        dataType: 'script',
        data: {
          curriculum_id: $(this).attr("curriculum_id"),
          object_type: $(this).attr("object_type"),
          object_id: $(this).attr("object_id")
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          return console.log("Loading curriculum detail is ok!");
        }
      });
    });
  });

}).call(this);
