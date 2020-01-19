class ContactsController < ApplicationController
  
  #GET request
  def new
    @contact = Contact.new
  end
  
  #POST request
  def create
    #mass assign of form fields into contact object
    @contact = Contact.new(contact_params)
    if @contact.save
      #Store form fields into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variables into contact mailer
      #email method and send mail
      ContactMailer.contact_email(name, email, body).deliver
      #Show message sent banner
      flash[:success] = "Message Sent"
      redirect_to new_contact_path
    else
      #if contact obj doesnt save, store errors, and redirect
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end 
  
  private
    #To collect data from forms using parameters
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end