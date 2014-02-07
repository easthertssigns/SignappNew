function equalHeight(group) {
    var tallest = 0;
    group.each(function () {
        var thisHeight = $(this).height();
        if (thisHeight > tallest) {
            tallest = thisHeight;
        }
    });
    group.height(tallest);

    //$('.blueColumn').height(tallest);
}

$(function () {
    var hoverIntentConfig = {
        over: showMenu, // function = onMouseOver callback (REQUIRED)
        timeout: 0, // number = milliseconds delay before onMouseOut
        out: hideMenu // function = onMouseOut callback (REQUIRED)
    };

    function showMenu() {
        $('.megaMenu', this).show();
        $(this).addClass('open');
    }

    function hideMenu() {
        $('.megaMenu', this).hide();
        $(this).removeClass('open');
    }

    $('nav ul li.topLevel').hoverIntent(hoverIntentConfig);

    $('.megaMenu').each(function () {
        var megaMenuColumns = $(this).children();
        equalHeight(megaMenuColumns);
    });

    function setMegaMenuSize() {
        var columnWidth = $(".megaMenu ul").outerWidth();
        var blueColumnWidth = $(".megaMenu .blueColumn").outerWidth(true);

        $('.megaMenu').each(function () {
            var columnLength = $('ul', this).length;
            if ($('.blueColumn', this).length > 0) {
                $(this).css({
                    display: 'none',
                    visibility: 'visible',
                    width: columnWidth * columnLength + blueColumnWidth
                });
            }
            else {
                $(this).css({
                    display: 'none',
                    visibility: 'visible',
                    width: columnWidth * columnLength
                });
            }
        });
    }

    setMegaMenuSize();

//    var basketHeight = $('#basketDropDown').outerHeight();
    $("#basketTab").live('click', function () {
        if ($(this).hasClass('toggled')) {
            $(this).removeClass('toggled');
            $('#basketContainer').animate({bottom: 8}, function () {
                $('#basketDropDown').hide();
                $(this).css({'z-index': 10});
            });
        } else {
            $(this).addClass('toggled');
            $('#basketDropDown').show();
            $('#basketContainer').css({'z-index': 30}).animate({bottom: -$('#basketDropDown').outerHeight() + 8});
        }
    });

    $('form#update-minicart a.delete').live('click', function (e) {
        $(this).parent().siblings('div[data-hook="minicart_item_quantity"]').find("input.line_item_quantity").val(0);
        $(this).parents('form').first().submit();
        $('#basketContainer').load(document.URL + ' #basketContainer > *', function () {
            $('#basketContainer').css({
                bottom: -$('#basketDropDown').outerHeight() + 8
            });
            $('#basketTab').addClass('toggled');
        });
        e.preventDefault();
    });
});