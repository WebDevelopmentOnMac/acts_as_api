class UsersController < ApplicationController
  
  before_filter do
    if params[:orm] == :active_record
      @user_model = User
    elsif params[:orm] == :mongoid
      @user_model = MongoUser
    end
  end
  
  def index
    @users = @user_model.all

    respond_to do |format|
      format.xml  { render_for_api params[:api_template].to_sym, :xml => @users, :root => :users }
      format.json { render_for_api params[:api_template].to_sym, :json => @users, :root => :users }
    end
  end
  
  def show
    @user = @user_model.find(params[:id])

    respond_to do |format|
      # :root => :user is only used here because we need it for the node name of the MongoUser model
      format.xml  { render_for_api params[:api_template].to_sym, :xml => @user, :root => :user }
      format.json { render_for_api params[:api_template].to_sym, :json => @user, :root => :user }
    end
  end  
  
end