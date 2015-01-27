(function($)
{

	// not fully supported in IE8
	if ($('html').is('.ie.lt-ie9'))
	{
		$('.container-fluid').css('visibility', 'visible').show();
		$('.pace').hide();
		return;
	}
    $('.container-fluid').css('visibility', 'visible').show();
    $(window).trigger('load');
//	Pace.once('done', function()
//	{
//		$('.container-fluid').css('visibility', 'visible').show();
//		$(window).trigger('load');
//	});

})(jQuery);