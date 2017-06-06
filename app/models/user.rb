class User < ApplicationRecord
	has_secure_password
	has_many :reservations, dependent: :destroy

	validates :name, :password, presence: true
	validates :password, length: { in: 0..32}
	validates :name, uniqueness: true

	# OAuth stuff
	devise :omniauthable, :omniauth_providers => [:facebook]
	def self.new_with_session(params, session)
	  super.tap do |user|
	    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	      user.email = data["email"] if user.email.blank?
	    end
	  end
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email_address = auth.info.email
	    user.password = "1"
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	  end
	end
end