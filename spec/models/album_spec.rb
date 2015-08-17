require 'rails_helper'

RSpec.describe Album, type: :model do
  it "has a valid factory" do
  	FactoryGirl.create(:album).should be_valid  	
  end
  it "has a title"  do
  	@album = FactoryGirl.create(:album)
  	@album.title.nil?.should == false
  end
  it "has a year" do
  	@album = FactoryGirl.create(:album)
  	@album.year.nil?.should == false
  end
end