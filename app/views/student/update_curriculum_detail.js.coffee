$("#divContent").html("<%= escape_javascript(render(:partial => 'student/content')) %>")
$("#divComments").html("<%= escape_javascript(render(:partial => 'comments/comments')) %>");
$('#load-detail-error').html('')