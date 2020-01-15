$(document).on('turbolinks:load', function() {

//========================side-naviのアコーディオン=============================

    $('li.main').click(function(){

        var targetClass = $(this).attr('class').split(" ")[0];

        if ($(this).hasClass('opened')) {
            $("." + targetClass + ".sub").slideUp();
            $(this).removeClass('opened');
        } else {

            if ($('.side-navi').find('.opened').length) {

                var openedClass = $('.opened').attr('class').split(" ")[0];
                
                $("." + openedClass + ".sub").slideUp();
                $('.opened').removeClass('opened');
            }

            $("." + targetClass + ".sub").slideDown();
            $(this).addClass('opened');
        }
    });


//========================商品登録のカラー登録フォームを増やす=============================

    $('#add-color-select').click(function() {
        $('#additional-form').clone().appendTo('#here');
    });


});