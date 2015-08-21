class Album < ActiveRecord::Base
	has_many :tracks, dependent: :destroy
	has_and_belongs_to_many :artists
	accepts_nested_attributes_for :tracks, allow_destroy: true
end
