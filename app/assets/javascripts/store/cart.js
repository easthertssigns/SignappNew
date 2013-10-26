$(function () {

    $(".line_item_quantity").after('<div class="inc qbutton blue button">+</div><div class="dec qbutton blue button">-</div>');
    $(".qbutton").click(function (event) {
        var $button = $(this);
        var oldValue = $(this).siblings(".line_item_quantity").val();
        var max = parseInt($(this).siblings(".line_item_quantity").attr("max"));

        if ($button.text() == "+") {
            var newVal = parseInt(oldValue) + 1;
        } else {
            if (oldValue >= 1) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                var newVal = 0
            }
        }
        $(this).siblings(".line_item_quantity").val(newVal);

        setTimeout(function() {
             $('#update-button').addClass("highlight").delay(1000).queue(function(next){
                $(this).removeClass("highlight");
                next();
            });
             $('.direction-arrow').animate({top: -45}).queue(function(next){
                $(this).animate({top: -30});
                next();
            });
        },1000)

    });


    if (($('form#update-cart')).is('*')) {
        return ($('form#update-cart a.delete')).show().on('click', function () {
            ($(this)).parents('.line-item').first().find('input.line_item_quantity').val(0);
            ($(this)).parents('form').first().submit();
            return false;
        });
    }

    if (location.href.indexOf("/checkout/delivery") != -1) {
        $('.checkout .progressBar .grid_4.billing').addClass('current');
        //$('.checkout .progressBar .grid_4.shipping').addClass('current');
    }

    if (location.href.indexOf("/checkout/payment") != -1) {
        $('.checkout .progressBar .grid_4.billing').removeClass('current').addClass('complete');
        $('.checkout .progressBar .grid_4.shipping').addClass('current');
       // $('.checkout .progressBar .grid_4.payment').addClass('current');
    }

    if (location.href.indexOf("/confirm") != -1) {
        $('.checkout .progressBar .grid_4.billing').removeClass('current').addClass('complete');
        $('.checkout .progressBar .grid_4.shipping').addClass('current');
        // $('.checkout .progressBar .grid_4.payment').addClass('current');
    }

    if (location.href.indexOf("/orders") != -1) {
        $('.checkout .progressBar .grid_4.billing').removeClass('current').addClass('complete');
        $('.checkout .progressBar .grid_4.shipping').addClass('complete');
        $('.checkout .progressBar .grid_4.payment').addClass('current');
    }



     if ($('#order_bill_address_attributes_country_id').length) {
         $('#order_bill_address_attributes_country_id, #order_ship_address_attributes_country_id').select2();
     }

    if ($('#payment-methods').length) {
         $('#payment-methods select').select2();
     }

});