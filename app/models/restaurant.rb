class Restaurant < ApplicationRecord
	has_many :timesegments

	validates :name, :presence => true, :uniqueness => true
	validates :table_number, :presence => true
end