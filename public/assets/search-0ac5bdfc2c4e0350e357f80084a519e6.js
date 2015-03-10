(function() {
  $(function() {
    return $(document).on('change', '#category_select', function(evt) {
      return $.ajax('/search/update_levels', {
        type: 'GET',
        dataType: 'script',
        data: {
          category_id: $("#category_select option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          return console.log("update_levels OK!");
        }
      });
    });
  });

}).call(this);
