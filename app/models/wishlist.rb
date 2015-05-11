class Wishlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  # attr_accessible :title, :body
end
