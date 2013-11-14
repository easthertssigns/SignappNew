$(window).load(function () {
    // Show hero slider when page has finished loading and remove loading animation
    $('#heroSlider .heroSlide:first').fadeIn(function () {
        $('#heroSlider').cycle({
            after:onAfter,
            before:onBefore,
            next:'#heroControls .next',
            prev:'#heroControls .prev',
            slideResize:false
        });
    });
    $('#heroContainer').removeClass('loading');

    // Animation controls for text on hero slider
    function onAfter() {
        $('h1, h2', this).fadeIn();
    }

    function onBefore() {
        $('#heroSlider h1, #heroSlider h2').hide();
    }

    // Fade in gallery area when page has finished loading
    $('#signCarousel .tileRow').fadeIn();
    $('#signCarousel').removeClass('loading');

    // Remove last gallery tile if there is an odd number of tiles
    var imageTile = $('.signCarousel .imageTile');
    var tileCount = $(imageTile).length;
    if (tileCount % 2 === 1) {
        $('.signCarousel .tileRow .imageTile:last').remove();
    }

});

// Document ready
$(function () {
    // Show arrows when the mouse is over the hero slider
    $('#heroContainer').hover(
        function () {
            $('#heroControls .arrowControl', this).stop(true, true).fadeIn();
        },
        function () {
            $('#heroControls .arrowControl', this).stop(true, true).fadeOut();
        }
    );

    // Fade in arrows to 100% opacity when mouse hovers over them
    $('.arrowControl').hover(
        function () {
            $('.arrow', this).stop(true, true).animate({opacity:1});
        },
        function () {
            $('.arrow', this).stop(true, true).animate({opacity:0.5});
        }
    );

    // Pop up Create Your Sign Now tab when mouse hovers over it
    $('#createYourSignNow').hover(
        function () {
            $(this).stop(true, true).animate({bottom:'0'}, 100);
        },
        function () {
            $(this).stop(true, true).animate({bottom:'-3px'}, 100);
        }
    );

    // Fade in background radial gradient when mouse hovers over steps area
    $('.threeSteps .grid_4').hover(
        function () {
            $('.radialGradient', this).stop(true, true).fadeIn();
        },
        function () {
            $('.radialGradient', this).stop(true, true).fadeOut();
        }
    );

    // Fade in arrows when mouse hovers over gallery area
    $('.howArePeopleUsingSignApp').hover(
        function () {
            $('.arrowControl', this).stop(true, true).fadeIn();
        },
        function () {
            $('.arrowControl', this).stop(true, true).fadeOut();
        }
    );

    // Old single row gallery area with push out animations
    /* $('#signCarousel').carouFredSel({
     width:'100%',
     height:457,
     auto:false,
     items:{
     visible:"+1"
     },
     scroll:1,
     prev:'.howArePeopleUsingSignApp .prev',
     next:'.howArePeopleUsingSignApp .next'
     });

     var imageTileHeight = $('#signCarousel img').height();
     var imageTileWidth = $('#signCarousel img').width();

     $('#signCarousel li').hover(function () {
     $(this).children('img').stop().animate({
     height:imageTileHeight * 2,
     width:imageTileWidth * 2
     }, 200, function () {
     $(this).siblings('.infoPanel').fadeIn(200);
     });
     $(this).siblings().children('img').stop().animate({
     height:imageTileHeight,
     width:imageTileWidth
     }, 200);
     $(this).siblings().children('.infoPanel').hide();
     }
     );*/

    // Gallery variables
    var tileContainer = $('.signCarousel');
    var imageTile = $('.signCarousel .imageTile');
    var tileWidth = imageTile.outerWidth();
    var imageHeight = $('.signCarousel .imageTile img').height();
    var imageWidth = $('.signCarousel .imageTile img').width();
    var zoomHeight = 400;
    var zoomWidth = 400;
    var tileCount = $(imageTile).length;
    var rowCount = tileCount / 2;

    // Pull gallery left by one tile width to prevent user from seeing panels being moved around
    $(tileContainer).css({
        marginLeft:-tileWidth,
        width:tileWidth * rowCount
    });

    // Split the total tiles in two and wrap them in row containers
    $(imageTile).slice(0, rowCount).wrapAll('<div class="tileRow topRow"></div>');
    $(imageTile).slice(rowCount).wrapAll('<div class="tileRow bottomRow"></div>');

    // Absolutely position each tile in the row based on the number of tiles and their width
    $('.tileRow').each(function () {
        $(this).find('.imageTile').each(function (tileIndex) {
            var left = tileIndex * tileWidth;
            $(this).css('left', left + 'px');
        });
    });

    // Hover intent configuration
    var hoverIntentConfig = {
        over:zoomTile, // function = onMouseOver callback (REQUIRED)
        timeout:0, // number = milliseconds delay before onMouseOut
        out:resetTile // function = onMouseOut callback (REQUIRED)
    };

    // Tile zoom animation
    function zoomTile() {
        if ($(this).parent('.bottomRow').length > 0) {
            $(this).css({
                borderWidth:2,
                opacity:1,
                zIndex:30
            }).stop(true, true).animate({
                    bottom:-41,
                    height:zoomHeight + 50,
                    marginLeft:-tileWidth / 2 - 2,
                    opacity:1,
                    width:zoomWidth
                }, 300, 'easeOutBack');
        }
        else {
            $(this).css({
                borderWidth:2,
                opacity:1,
                zIndex:30
            }).stop(true, true).animate({
                    height:zoomHeight + 50,
                    marginLeft:-tileWidth / 2 - 2,
                    opacity:1,
                    top:-26,
                    width:zoomWidth
                }, 300, 'easeOutBack');
        }
        $('img', this).stop(true, true).animate({
            height:zoomHeight,
            width:zoomWidth
        }, 300, 'easeOutBack');
        $('.infoPanel', this).stop(true, true).delay(300).fadeIn(300);
        $(tileContainer).find(imageTile).not(this).stop(true, true).animate({
            opacity:0.7
        });
    }

    // Tile reset animation
    function resetTile() {
        if ($(this).parent('.bottomRow').length > 0) {
            $(this).stop(true, true).animate({
                bottom:0,
                height:imageHeight,
                marginLeft:0,
                width:imageWidth
            }, 100, 'easeInBack', function () {
                $(this).css({
                    borderWidth:1,
                    zIndex:1
                });
            });
        }
        else {
            $(this).stop(true, true).animate({
                height:imageHeight,
                marginLeft:0,
                top:0,
                width:imageWidth
            }, 100, 'easeInBack', function () {
                $(this).css({
                    borderWidth:1,
                    zIndex:1
                });
            });
        }
        $('img', this).stop(true, true).animate({
            height:imageHeight,
            width:imageWidth
        }, 100, 'easeInBack');
        $('.infoPanel', this).stop(true, true).hide();
        $(tileContainer).find(imageTile).not(this).stop(true, true).delay(200).animate({
            opacity:1
        });
    }

    // Hover intent for tiles to prevent excessive animation
    $('.imageTile').hoverIntent(hoverIntentConfig);

    // Move gallery right when the next arrow is clicked, and re-position tiles accordingly to create infinite slider
    $('.howArePeopleUsingSignApp .next').click(function () {
        var positionOffset = $('.signCarousel .tileRow .imageTile:last').position();
        var rowWidth = tileWidth * rowCount;
        $('.signCarousel .tileRow').animate({left:'-=' + tileWidth}, 'easeInOutExpo');
        $('.signCarousel .tileRow.topRow .imageTile:last').after($('.signCarousel .tileRow.topRow .imageTile:first').css('left', positionOffset.left + tileWidth));
        $('.signCarousel .tileRow.topRow .imageTile:last').css({left:positionOffset + rowWidth});
        $('.signCarousel .tileRow.bottomRow .imageTile:last').after($('.signCarousel .tileRow.bottomRow .imageTile:first').css('left', positionOffset.left + tileWidth));
        $('.signCarousel .tileRow.bottomRow .imageTile:last').css({left:positionOffset + rowWidth});
    });

    // Move gallery left when the previous arrow is clicked, and re-position tiles accordingly to create infinite slider
    $('.howArePeopleUsingSignApp .prev').click(function () {
        var positionOffset = $('.signCarousel .tileRow .imageTile:first').position();
        var rowWidth = tileWidth * rowCount;
        $('.signCarousel .tileRow').animate({left:'+=' + tileWidth});
        $('.signCarousel .tileRow.topRow .imageTile:first').before($('.signCarousel .tileRow.topRow .imageTile:last').css('left', positionOffset.left - tileWidth));
        $('.signCarousel .tileRow.topRow .imageTile:first').css({left:positionOffset + rowWidth});
        $('.signCarousel .tileRow.bottomRow .imageTile:first').before($('.signCarousel .tileRow.bottomRow .imageTile:last').css('left', positionOffset.left - tileWidth));
        $('.signCarousel .tileRow.bottomRow .imageTile:first').css({left:positionOffset + rowWidth});
    });

    // Swap icon and fade in radial gradient when mouse hovers over features area
    $('.featurePanels .grid_4').hover(function () {
        $('.icon', this).stop(true, true).animate({opacity:0});
        $('.icon.hover', this).stop(true, true).animate({opacity:1});
        $('.radialGradient', this).stop(true, true).fadeIn();
    }, function () {
        $('.icon', this).stop(true, true).animate({opacity:1});
        $('.icon.hover', this).stop(true, true).animate({opacity:0});
        $('.radialGradient', this).stop(true, true).fadeOut();
    });
});