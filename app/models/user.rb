class User < ApplicationRecord
	has_secure_password
	has_many :reservations

	validates :name, :password, presence: true
	validates :password, length: { in: 6..15 }
	validates :name, uniqueness: true
end