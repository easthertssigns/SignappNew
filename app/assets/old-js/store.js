$(function () {
    $('.choose-button').hover(
        function () {
            var $this = $(this);
            $(this).data('initialText', $this.text());
            $(this).text("Ready? Let's make your sign!");
        }, function () {
            var $this = $(this);
            $(this).text($this.data('initialText'));
        });

    $('.product-image').hover(
        function () {
            $('.imageOverlay', this).stop().animate({top:0});
        },
        function () {
            $('.imageOverlay', this).stop().animate({top:120});
        }
    );

    $('.priceWrapper .price').html(function () {
        var text = $(this).text().split(".");
        var last = text.pop();
        return text.join(".") + (text.length > 0 ? "<sup>." + last + "</sup>" : last);
    });

    function format(shape) {
        if (!shape.id) return shape.text; // optgroup
        return "<img class='shape' src='/assets/shapes/" + shape.id.toLowerCase() + ".png'/>" + shape.text;
    }

    //$("#shapeSelect").select2({
    //    width:'resolve',
    //    minimumResultsForSearch:9999,
    //    formatResult:format,
    //    formatSelection:format
    //});

    //$("#sizeSelect").select2({
    //    width:'resolve',
    //    minimumResultsForSearch:9999
    //});
});