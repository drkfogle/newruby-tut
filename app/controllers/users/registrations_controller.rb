class Users::RegistrationsController < Devise::RegistrationsController
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
end