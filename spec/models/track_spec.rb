require 'rails_helper'

RSpec.describe Track, type: :model do
  it "has a valid factory" do
  	FactoryGirl.create(:track).should be_valid  	
  end
  it "has a title"  do
  	@track = FactoryGirl.create(:track)
  	@track.title.nil?.should == false
  end
  it "has a track number" do
  	@track = FactoryGirl.create(:track)
  	@track.track_number.nil?.should == false
  end
  it "has a length in seconds" do
  	@track = FactoryGirl.create(:track)
  	@track.length_in_seconds.nil?.should == false  	
  end
end
