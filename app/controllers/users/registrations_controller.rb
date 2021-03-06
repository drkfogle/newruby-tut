class Users::RegistrationsController < Devise::RegistrationsController
  
  before_action :select_plan, only: :new
   # Extend default Devise gem behavior so that
   # users signing up with the Pro account save with a special
   # Stripe subscription function, otherwise a basic subscription save
   def create
      super do |resource|
        if params[:plan]
          resource.plan_id = params[:plan]
          if resource.plan == 2
            resource.save_with_subscription
          else
            resource.save
          end
        end
      end
   end
   
   private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end  
end