$(document).on('turbolinks:load', function() {
    
    /======================sticky header==============================/

    $(".navi-wrapper").each(function() {

        var $window = $(window),
            $navi = $(this),
            naviOffSetTop = $navi.offset().top;

        $window.on('scroll', function() {
            if ($window.scrollTop() > naviOffSetTop) {
                $navi.addClass("sticky");
            } else {
                $navi.removeClass("sticky");
            }
        });

        $window.trigger('scroll');
    });


    /======================navigationのネスト==============================/

    $('.nest').click(function() {

        if ($(this).hasClass("picked")) {
            
            $(this).removeClass("picked");
            $(".opened").slideUp().removeClass("opened");
        
        } else {

            if ($(".navi-wrapper").find(".opened")) {
                $(".opened").parent().children(".nest").removeClass("picked");
                $(".opened").slideUp().removeClass("opened");
            }

            $(this).parent().children('.navi-items-list').slideDown().addClass("opened");
            $(this).addClass("picked");
        }
    });

    $('.close-navi-items-list').click(function() {

        if ($(".opened-nest").length) {
            $(".opened-nest").parent().removeClass("picked");
            $(".opened-nest").slideUp().removeClass("opened-nest");
        }

        $(this).parent().slideUp().removeClass("opened");
        $(".nest").removeClass("picked");
    });

    /--------------さらにネスト---------------/

    $(".more-nest-list-title").click(function() {

        if ($(this).parent().hasClass("picked")) {
            
            $(this).parent().removeClass("picked");
            $(".opened-nest").slideUp().removeClass("opened-nest");

        } else {

            if ($(".navi-items-list").find(".opened-nest")) {
                $(".opened-nest").parent().removeClass("picked");
                $(".opened-nest").slideUp().removeClass("opened-nest");
            }
            
            $(this).parent().children(".more-nest-list").slideDown().addClass("opened-nest");
            $(this).parent().addClass("picked");

        }
    });

    $(".close-more-nest-list").click(function() {
        $(this).parent().parent().removeClass("picked");
        $(this).parent().slideUp().removeClass("opened-nest");
    });

    /======================オーダー画面中の会員登録===========================/
    
    $('#sign-in-during-shopping').click(function() {
        $('#acordion1').slideDown();
        $('#sign-up-or-not').slideUp();
        $('#login-form-during-shopping').slideUp();
        $('#editable-form').attr('action', '/users/create_during_shopping');
    });


    /==================how to pay のアコーディオン========================/

    $('[name="order[method_of_payment]"]:radio').change( function() {
        if($('[id=order_method_of_payment_クレジットカード]').prop('checked')){
          $('#acordion2').slideDown();
        } else if ($('[id=order_method_of_payment_代引き]').prop('checked')) {
          $('#acordion2').slideUp();
        } 
    });

});



