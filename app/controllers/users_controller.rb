class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to new_user_path
    else
      render :action => 'new'
    end
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    if current_user.has_role? :admin
      helper_destroy
    elsif current_user.has_role? :manager and !@user.has_role? :admin and !@user.has_role? :manager
      helper_destroy
    else
      redirect_to users_path, :alert => "Can't delete this user."
    end
  end

  def helper_destroy
    user = User.find(params[:id])
    loans = Loan.find_all_by_user_id(user.id)
    loans.each do |loan|
      loan.destroy
    end
      unless user == current_user
        user.destroy
        redirect_to users_path, :notice => "User deleted."
      else
        redirect_to users_path, :notice => "Can't delete yourself."
      end
  end
end