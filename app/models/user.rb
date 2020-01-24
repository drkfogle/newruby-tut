class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        
  belongs_to :plan
  # If pro user passes validations (email, password, etc)
  # Call Stripe in order to set up subscription upon charging customer
  # Stripe responds back with customer data and store customer id as customer token
  # Saving the user
  def save_with_subscription
    if valid?
     customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token) 
     self.stripe_customer_token = customer.id
     save!
    end
  end
end
