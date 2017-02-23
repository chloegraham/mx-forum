class API::SessionsController < ApplicationController#Devise::SessionsController
  #skip_before_filter :verify_authenticity_token,
   #                  :if => Proc.new { |c| c.request.format == 'application/json' }

  #respond_to :json

  # login
  # accepts a user JSON object as POST data with an email and a password parameters and returns an auth_token if the user exists in the database and the password is correct
  
  #before_create :generate_authentication_token

  #ef generate_authentication_token
    #loop do
      #self.authentication_token = SecureRandom.base64(64)
      #break unless User.find_by(authentication_token: authentication_token)
    #end
  #end


  def create
    # => @var = JSON.parse(params[:name_of_the_JSON_fields])

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end


    #warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token } }
  end

  # logout
  # expects an auth_token parameter in the url.
  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end