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
        submitBtn.val("Processing").prop('disabled', true);
        
        
        //collect credit card info
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        //Use stripe JS library for card errors
        var error = false;
        
        //validate card number
        if (!Stripe.card.validateCardNumber(ccNum)){
            error = true;
            alert('The credit card appears to be invalid.');
        }
        
        //validate CVC number
        if (!Stripe.card.validateCVC(cvcNum)){
            error = true;
            alert('The CVC appears to be invalid.');
        }
        
        //validate card number
        if (!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            alert('The expiration date appears to be invalid.');
        }
        
        if(error){
            //if there are errors dont send to stripe, otherwise do so
            submitBtn.prop('disabled', false).val("Sign Up")
        } else {
        //Send info to stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
            return false;            
        }
    });
    
    //stripe will return card token
    function stripeResponseHandler(status, response){
        //Get token from response
        var token = response.id;
        
        //inject token in hidden field
        theForm.append( $('<input type = "hidden" name="user[stripe_card_token]">')val() );
        
        //Submit form to app
        theForm.get(0).submit();
    }
    
});