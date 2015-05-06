class Book < ActiveRecord::Base
  belongs_to :loans
  attr_accessible :author, :format, :isbn, :title, :borrowed
  validates_presence_of :author, :format, :isbn, :title
end
