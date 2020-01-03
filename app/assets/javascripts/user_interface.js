
/======================動作テスト===================================/

$(document).on('turbolinks:load', function() {
    $(".test").text("jQuery稼働テスト(稼働中)");

});


/======================sticky header==============================/

$(document).on('turbolinks:load', function() {

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
});