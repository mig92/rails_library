class Loan < ActiveRecord::Base
  attr_accessible :book_id, :return_date, :user_id
end
