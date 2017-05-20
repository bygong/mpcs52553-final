class Reservation < ApplicationRecord
	belongs_to :time_segment
	belongs_to :customer, class_name: 'User', foreign_key: 'user_id'

	validates :customer, uniqueness: {scope: :time_segment, message: "can only book one table"}
	validates :size, presence: true
end