class Book < ActiveRecord::Base
  attr_accessible :author, :format, :isbn, :title
end
