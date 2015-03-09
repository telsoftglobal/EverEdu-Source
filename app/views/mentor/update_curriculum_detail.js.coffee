$("#divContent").html("<%= escape_javascript(render(:partial => 'mentor/content')) %>");
$('#comments-list').html('<%= escape_javascript(render partial: @commentable.get_lastest_comments) %>');

$('#comment-error').html('');
$("#comment").val('');