class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    @readers = User.where('role' => 'reader')
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


  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User updated."
    else
      render :action => 'edit'
    end
  end
    
  def destroy
    helper_destroy
  end

  def helper_destroy
    user = User.find(params[:id])
    loans = Loan.find_all_by_user_id(user.id)
    wishes = Wishlist.find_all_by_user_id(user.id)
    wishes.each do |wish|
      wish.destroy
    end
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