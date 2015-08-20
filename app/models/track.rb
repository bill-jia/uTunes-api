class Track < ActiveRecord::Base
  belongs_to :album, counter_cache: true
end
