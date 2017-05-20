class DateSegment < ApplicationRecord
	belongs_to :restaurant
	has_many :time_segments
	has_many :reservations, class_name: "reservation", through: :time_segments

	validates :restaurant_id, :date, presence: true

	def table_left
		time_segment_list = TimeSegment.where(date_segment_id: self.id)
		left = 0
		time_segment_list.each do |seg|
			left += seg.table_left
		end
		return left
	end
end
