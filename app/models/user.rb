class User < ApplicationRecord

  # Devise modules...
  
  # Roles
  enum role: { user: 'user', admin: 'admin' }

  # Set default role to 'user' if not specified
  after_initialize :set_default_role, if: :new_record?


   # Validations
   validates :password, presence: true, if: :password_required?
   
  private

  def password_required?
    password_set || new_record?
  end

  def set_default_role
    self.role ||= :user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
