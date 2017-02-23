class API::UsersController < ApplicationController

  #http_basic_authenticate_with :name => "myfinance", :password => "credit123"

 # skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_user, :except => [:index, :create]

  #respond_to :json

 # curl -H "Content-Type:application/json; charset=utf-8" -d "'task':{'title':'something to do','order':1,'completed':false}" http://localhost:3000/tasks
 # localhost:3000/api/users -d "{\"user\":{\"first_name\":\"blah\",\"email\":\"user@example.com\",\"password\":\"secret\"}}

  #curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/api/users -d "{\"user\":{\"first_name\":\"testinguser\",\"email\":\"using@example.com\",\"password\":\"secret\"}} (id = 104)

  def fetch_user
    @user = User.find_by_id(params[:id])
  end

  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users }
      format.xml { render xml: @users }
    end
  end

  def show
    binding.pry
    #respond_to do |format|
    #  format.json { render json: @user }
    #  format.xml { render xml: @user }
    #end
    #@user = User.find_by_id(params[:id])
    render json: @user
    #render :json => { :first_name => @user.first_name, :email => @user.email }
  end

  #def show
  #  @user = User.find_by_id(params[:id])
  #  render json: @user
  #end

  def create
    @user = User.new(params[:user])
    binding.pry
    #@user.temp_password = Devise.friendly_token
    respond_to do |format|
      if @user.save
        #format.json { render json: @user, status: :created }
        #format.xml { render xml: @user, status: :created }
        render json: { user_id: @user.id }#, status: :created
      else
        #format.json { render json: @user.errors, status: :unprocessable_entity }
        #format.xml { render xml: @user.errors, status: :unprocessable_entity }
        render json: { user_id: 0 }
      end
      #render json: { auth_token: @user.api_key, user_id: @user.id }, status: :created

    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end