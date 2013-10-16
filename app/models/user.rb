class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates(:name, presence: true)
  has_many :videos, dependent: :destroy
  after_create :assign_guest_role
  private
  def assign_guest_role
    self.add_role :guest
  end
end
