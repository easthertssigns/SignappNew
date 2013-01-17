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
        over:showMenu, // function = onMouseOver callback (REQUIRED)
        timeout:0, // number = milliseconds delay before onMouseOut
        out:hideMenu // function = onMouseOut callback (REQUIRED)
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
                    display:'none',
                    visibility:'visible',
                    width:columnWidth * columnLength + blueColumnWidth
                });
            }
            else {
                $(this).css({
                    display:'none',
                    visibility:'visible',
                    width:columnWidth * columnLength
                });
            }
        });
    }

    setMegaMenuSize();

    var basketHeight = $('#basketDropDown').outerHeight();
    $("#basketTab").toggle(function () {
        $('#basketDropDown').show();
        $('#basketContainer').animate({bottom:-basketHeight + 8});
    }, function () {
        $('#basketContainer').animate({bottom:8}, function () {
            $('#basketDropDown').hide();
        });
    });

    $('form#update-minicart a.delete').live('click', function (e) {
        $(this).parent().siblings('div[data-hook="minicart_item_quantity"]').find("input.line_item_quantity").val(0);
        $(this).parents('form').first().submit();
        e.preventDefault();
    });
});