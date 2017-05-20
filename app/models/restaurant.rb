class Restaurant < ApplicationRecord
	has_many :date_segments

	validates :name, presence: true, uniqueness: true
	validates :table_number, presence: true
end