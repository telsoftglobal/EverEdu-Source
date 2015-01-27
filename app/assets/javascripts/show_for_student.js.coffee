# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'click', '#divRight a', (evt) ->
    #$('#divRight a').css('color','#913228')
    #$(this).css('color','blue')
    $('#divRight a').removeClass("strong");
    $(this).addClass("strong");
    $.ajax '/student/update_curriculum_detail',
      type: 'GET'
      dataType: 'script'
      data: {
        curriculum_id:$(this).attr("curriculum_id")
        object_type:$(this).attr("object_type")
        object_id:$(this).attr("object_id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Loading curriculum detail is ok!")



