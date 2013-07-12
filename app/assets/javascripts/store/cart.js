$(function () {

    $(".line_item_quantity").after('<div class="inc qbutton cream button">+</div><div class="dec qbutton cream button">-</div>');
    $(".qbutton").click(function (event) {
        var $button = $(this);
        var oldValue = $(this).siblings(".line_item_quantity").val();
        var max = parseInt($(this).siblings(".line_item_quantity").attr("max"));

        if ($button.text() == "+") {
            var newVal = parseInt(oldValue) + 1;

        } else {
            if (oldValue >= 2) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                var newVal = 1
            }
        }
        $(this).siblings(".line_item_quantity").val(newVal);
    });


    if (($('form#update-cart')).is('*')) {
        return ($('form#update-cart a.delete')).show().on('click', function () {
            ($(this)).parents('.line-item').first().find('input.line_item_quantity').val(0);
            ($(this)).parents('form').first().submit();
            return false;
        });
    }

});