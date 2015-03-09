$(function()
{
    var bWizardTabClass = '';
    $('.wizard').each(function()
    {
        if ($(this).is('#rootwizard'))
            bWizardTabClass = 'bwizard-steps';
        else
            bWizardTabClass = '';

        var wiz = $(this);

        $(this).bootstrapWizard(
            {
                onTabClick: function(tab, navigation, index) {

                    return false;
                },
                onNext: function(tab, navigation, index)
                {



                    var $valid = $("#curriculum_form").valid();
                    if(!$valid) {
//                        $validator.focusInvalid();
                        return false;
                    }


                },
                onLast: function(tab, navigation, index)
                {
                    // Make sure we entered the title
//                    if(!wiz.find('#inputTitle').val()) {
//                        alert('You must enter the product title');
//                        wiz.find('#inputTitle').focus();
//                        return false;
//                    }
                },
                //			onTabClick: function(tab, navigation, index)
                //			{
                //				// Make sure we entered the title
                //				if(!wiz.find('#inputTitle').val()) {
                //					alert('You must enter the product title');
                //					wiz.find('#inputTitle').focus();
                //					return false;
                //				}
                //			},
                onTabShow: function(tab, navigation, index)
                {
                    if(index==1)
                    {
                        if($(".widget-body").find("button.buttonSave").css("display")!="none"){
                            disableNavigator();
                        }

                        //console.log($("#tab2-2").find("input.requiredfield100"));
                    }



                    var $total = navigation.find('li:not(.status)').length;
                    var $current = index+1;
                    var $percent = ($current/$total) * 100;

                    if (wiz.find('.progress-bar').length)
                    {
                        wiz.find('.progress-bar').css({width:$percent+'%'});
                        wiz.find('.progress-bar')
                            .find('.step-current').html($current)
                            .parent().find('.steps-total').html($total)
                            .parent().find('.steps-percent').html(Math.round($percent) + "%");
                    }

                    // update status
                    if (wiz.find('.step-current').length) wiz.find('.step-current').html($current);
                    if (wiz.find('.steps-total').length) wiz.find('.steps-total').html($total);
                    if (wiz.find('.steps-complete').length) wiz.find('.steps-complete').html(($current-1));

                    // mark all previous tabs as complete
                    navigation.find('li:not(.status)').removeClass('primary');
                    navigation.find('li:not(.status):lt('+($current-1)+')').addClass('primary');

                    // If it's the last tab then hide the last button and show the finish instead
                    if($current >= $total) {
                        wiz.find('.pagination .next').hide();
                        wiz.find('.pagination .finish').show();
                        wiz.find('.pagination .finish').removeClass('disabled');
                    } else {
                        wiz.find('.pagination .next').show();
                        wiz.find('.pagination .finish').hide();
                    }

                },
                tabClass: bWizardTabClass,
                nextSelector: '.next',
                previousSelector: '.previous',
                firstSelector: '.first',
                lastSelector: '.last'
            });

        wiz.find('.finish').click(function()
        {
//            console.log($('#curriculum_form').serializeArray());
            wiz.find("a[data-toggle*='tab']:first").trigger('click');

        });
    });
});