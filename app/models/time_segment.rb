class TimeSegment < ApplicationRecord
	belongs_to :restaurant
	belongs_to :date_segment
	has_many :reservations, dependent: :destroy
	has_many :customers, class_name: "User", through: :reservations

	validates :restaurant_id, :time, :date_segment, presence: true
	validates :table_left, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
end
