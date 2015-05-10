class HomeController < ApplicationController
  def index
    @users = User.all
    @books = Book.all
    if user_signed_in?
      @loans = Loan.find_all_by_user_id(current_user.id)
    end
  end
end
