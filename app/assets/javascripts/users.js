/* global $, Stripe */
//Document Ready
$(document).on('turbolinks:load', function(){
    var theForm = $('pro_form');
    var submitBtn = $('#form-signup-btn');
    //Set Stripe Public Key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') )
    
    // when user clicks submit btn on form
    submitBtn.click(function(e){
        //prevent default 
        e.preventDefault()
        
        //collect credit card info
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        //Send info to stripe
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
    });
})