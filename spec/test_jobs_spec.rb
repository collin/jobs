require 'helper'

describe Jobs do
  let(:json_hash) { {'class' => 'Object', 'id' => '999'} }
  
  it "should return a String place holder for non-existent objects" do
    Object.stub(:find_by_id => nil)
    Jobs.load_args([json_hash]).should == ["#{json_hash['class']}<#{json_hash['id']}>"]
  end
  
  it "should return an instance of the found object" do
    Object.stub(:find_by_id => Object.new)
    Jobs.load_args([json_hash]).first.should be_an_instance_of Object
  end
end