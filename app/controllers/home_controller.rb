class HomeController < ApplicationController
  def index
    @users = User.all
    @books = Book.all
  end
end
