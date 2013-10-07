$(window).load(function () {
    var canvasWrapperHeight = $(window).height() - 131;
    var canvasMargin = $('.canvas-container').css("margin-left");
    $("#loadingOverlay").fadeOut();
    $('#canvasZoomWrapper').css('height', canvasWrapperHeight);
    $('#toolPalette').css('right', (parseInt(canvasMargin, 10) - 93) + 'px');
    $('#majorFunctions').css('left', (parseInt(canvasMargin, 10)) + 'px');

    function hideTourOverlay() {
        $('#addText, #addShape, #addBorder, .priceWrapper, #addToBasket').removeClass('overlay');
        $('#tourOverlay').fadeOut();
    }

    $("#joyRidePopup0 .button").live("click", function () {
        $('#addText').removeClass('overlay');
        $('#addShape').addClass('overlay');
    });
    $('#joyRidePopup1 .button').live("click", function () {
        $('#addShape').removeClass('overlay');
        $('#addBorder').addClass('overlay');
    });
    $('#joyRidePopup2 .button').live("click", function () {
        $('#addBorder').removeClass('overlay');
        $('.priceWrapper, #addToBasket').addClass('overlay');
    });

    $('#startTutorial').click(function () {
        $('#tourOverlay').fadeIn();
        $(this).joyride({
            tipContent: '#tourSteps',
            postRideCallback: hideTourOverlay
        });
    });
});

$(function () {
    $(window).resize(function () {
        var canvasWrapperHeight = $(window).height() - 131;
        var canvasMargin = $('.canvas-container').css("margin-left");
        $('#canvasZoomWrapper').css('height', canvasWrapperHeight);
        $('#toolPalette').css('right', (parseInt(canvasMargin, 10) - 93) + 'px');
        $('#majorFunctions').css('left', (parseInt(canvasMargin, 10)) + 'px');
    });

    $('#toolPalette').draggable({
        containment: '#canvasZoomWrapper',
        handle: '#grabHandle',
        scroll: false
    });

    function fontFamily(fontFamily) {
        if (!fontFamily.id) return fontFamily.text; // optgroup
        return "<span style='font-family: " + fontFamily.id + "'>" + fontFamily.text + "</span>";
    }

    $('#fontFamily').select2({
        formatResult: fontFamily,
        formatSelection: fontFamily,
        minimumResultsForSearch: 5,
        width: "element"
    });

    function shapeSelect(shape) {
        if (!shape.id) return shape.text; // optgroup
        // alert(shape.id.replace("id_", ""));

        if (!isNaN(shape.id.replace("id_", "")))
        {
            return "<object type='image/svg+xml' data='/custom_sign/get_custom_shape_svg/" + shape.id.toLowerCase().replace("id_", "") + ".svg'/>" + shape.text;
        }
        else
        {
            return "<object type='image/svg+xml' data='/assets/svg/" + shape.id.toLowerCase() + ".svg'/>" + shape.text;
        }

    }

    $('#shapeSelect').select2({
        formatResult: shapeSelect,
        formatSelection: shapeSelect,
        minimumResultsForSearch: 5,
        placeholder: "Select a Shape",
        width: "element"
    });

//    function borderSelect(border) {
//        if (!border.id) return border.text; // optgroup
//        return "<object data='/assets/svg/" + border.id.toLowerCase() + ".svg'/>" + border.text;
//    }

    $('#borderSelect').select2({
//        formatResult:borderSelect,
//        formatSelection:borderSelect,
        minimumResultsForSearch: 1000,
        placeholder: "Select a Border",
        width: "element"
    });

    $('.showPaletteOnly').spectrum({
        showPaletteOnly: true,
        clickoutFiresChange: false,
        palette: [
            ['#ff8080', '#ffff80', '#80ff80', '#00ff80', '#80ffff', '#0080ff', '#ff80c0', '#ff80ff'],
            ['#ff0000', '#ffff00', '#80ff00', '#00ff40', '#00ffff', '#0080c0', '#8080c0', '#ff00ff'],
            ['#804040', '#ff8040', '#00ff00', '#008080', '#004080', '#8080ff', '#800040', '#ff0080'],
            ['#800000', '#ff8000', '#008000', '#008040', '#0000ff', '#0000a0', '#800080', '#8000ff'],
            ['#400000', '#804000', '#004000', '#004040', '#000080', '#000040', '#400040', '#400080'],
            ['#000000', '#808000', '#808040', '#808080', '#408080', '#c0c0c0', '#400040', '#ffffff']
        ]
    });

    $(".sp-palette-container .sp-palette").append('<div class="testing-this sp-cf sp-palette-row sp-palette-row-selection">Engraved</div>');

    $('.priceWrapper .price').html(function () {
        var text = $(this).text().split(".");
        var last = text.pop();
        return text.join(".") + (text.length > 0 ? "<sup>." + last + "</sup>" : last);
    });

    $('#toolPalette .tool, #addTextMenu .function').qtip();

    var footerHeight = $('#footerWrapper').outerHeight();

    $('#footerWrapper').css({
        bottom: -footerHeight
    });

    $('#footerTab').toggle(
        function () {
            $('#footerWrapper').animate({bottom: 0});
        },
        function () {
            $('#footerWrapper').animate({bottom: -footerHeight});
        }
    )

});

