class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  attr_accessible :return_date, :book_id, :user_id, :status
  before_create :default_status!
  
  def default_status!
    self.status ||= 'Active'
  end
end
