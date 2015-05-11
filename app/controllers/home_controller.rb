class HomeController < ApplicationController
  def index
    @users = User.all
    @books = Book.all
    if user_signed_in?
      @loans = Loan.find_all_by_user_id(current_user.id)
      @mywishlists = Wishlist.where('user_id' => current_user.id)
      @myloans_active = Loan.where('status' => 'Active', 'user_id' => current_user.id)
      @myloans_delivered = Loan.where('status' => 'Delivered', 'user_id' => current_user.id)
    end
  end
end
