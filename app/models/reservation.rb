class Reservation < ApplicationRecord
	belongs_to :timesegment
	belongs_to :customer, class_name: 'User', foreign_key: 'user_id'

	validates :customer, :uniqueness => {scope: :timesegment, message: "can only book one table"}
end