class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :token_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :omniauth_providers => [:facebook]

  validates(:name, presence: true)
  has_many :videos, dependent: :destroy
  after_create :assign_guest_role, :generate_authen_token

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
      )
    end
    user
  end

  private
  def assign_guest_role
    if self.has_role?(:admin)
      self.remove_role(:admin)
    end
    if self.has_role?(:guest)
      self.remove_role(:guest)
    end
    self.add_role(:guest)
  end
  def generate_authen_token
    self.ensure_authentication_token!
  end
end
