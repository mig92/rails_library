class User < ActiveRecord::Base
  has_many :loans
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :default_role!

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role

  ROLES = %w{ admin manager reader }

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'teacher'
  end

  def reader?
    role == 'student'
  end

  private

  def default_role!
    self.role ||= 'reader'
  end
  
end
