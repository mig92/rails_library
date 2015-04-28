class Book < ActiveRecord::Base
  attr_accessible :author, :format, :isbn, :title
  validates_presence_of :author, :format, :isbn, :title
end
