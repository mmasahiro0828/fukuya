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
        $('#last-additional-form').clone().appendTo('#additional-form-wrapper');
        $('#remove-color-select').show();

        if ($('.additional-form').length > 6) {
            $(this).hide();
        }

    });

    $('#remove-color-select').click(function() {
        $('#last-additional-form').remove();
        $('#add-color-select').show();

        if ($('.additional-form').length == 1) {
            $(this).hide();
        }
    });

    //========================商品登録のサイズ登録フォームを増やす=============================

    $('#add-size-select').click(function() {
        $('#last-additional-form-2').clone().appendTo('#additional-form-wrapper-2');
        $('#remove-size-select').show();

        if ($('.additional-form-2').length > 10) {
            $(this).hide();
        }

    });

    $('#remove-size-select').click(function() {
        $('#last-additional-form-2').remove();
        $('#add-size-select').show();

        if ($('.additional-form-2').length == 1) {
            $(this).hide();
        }
    });

    //========================商品登録の採寸項目登録フォームを増やす=============================

    $('#add-mi-select').click(function() {
        $('#last-additional-form-3').clone().appendTo('#additional-form-wrapper-3');
        $('#remove-mi-select').show();

        if ($('.additional-form-3').length > 10) {
            $(this).hide();
        }

    });

    $('#remove-mi-select').click(function() {
        $('#last-additional-form-3').remove();
        $('#add-mi-select').show();

        if ($('.additional-form-3').length == 1) {
            $(this).hide();
        }
    });


});