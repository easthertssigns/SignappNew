
$(function () {

    ImageGallery();


    if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i))) {
        $('.MagicZoom').bind('touchstart', function () {
            $('.zoom-image, #zoom, .product-details').animate({opacity: 0}, 200);
        });
        $('.MagicZoom').bind('touchend', function () {
            $('.zoom-image, .product-details').delay(100).animate({opacity: 1}, 200);
            $('#zoom').delay(100).animate({opacity: 0.5});
        });
    }

    // Set up image gallery
    function ImageGallery() {
        var currentIndex = 0; // store current slide index displayed
        $('ul.dot_nav li:first-child').addClass('current');
        var img = $('.gallery_image'); // store slides collection

        function showImage(index) {
            img.eq(currentIndex).css({'opacity': 0, 'visibility': 'hidden'});

            // set current index : check in slides collection length
            currentIndex = index;
            if (currentIndex < 0)
                currentIndex = img.length - 1;

            else if (currentIndex >= img.length)
                currentIndex = 0;
            // display slide
            img.eq(currentIndex).css({'opacity': 1, 'visibility': 'visible'});
            // menu selection
            $('ul.dot_nav li').removeClass('current').eq(currentIndex).addClass('current')
        }

        // bind ul links

        $('ul.dot_nav li').click(function () {
            if (!$(this).hasClass('current')) {
                showImage($(this).index());
                $(this).addClass('current').siblings().removeClass('current');
            }
        });

        $('.prev').click(function () {
            showImage(currentIndex - 1)
        });

        $('.next').click(function () {
            showImage(currentIndex + 1)
        });

        showImage(0);

    }

});



