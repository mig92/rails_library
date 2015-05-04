class Book < ActiveRecord::Base
  has_and_belongs_to_many :loans
  attr_accessible :author, :format, :isbn, :title
  validates_presence_of :author, :format, :isbn, :title
end
