class Album < ActiveRecord::Base
	has_many :tracks, dependent: :destroy
	accepts_nested_attributes_for :tracks, allow_destroy: true
end
