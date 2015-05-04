class User < ActiveRecord::Base
  has_many :loans
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => [:admin, :reader, :manager]
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
end
