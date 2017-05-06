class Timesegment < ApplicationRecord
	belongs_to :restaurant
	has_many :reservations
	has_many :customers, class_name: "User", through: :reservations

	validates :restaurant_id, :time, :presence => true
end
