class Producer < ActiveRecord::Base
  has_and_belongs_to_many :albums
  # TODO: Make role an association-specific attribute or ignore it altogether
end
