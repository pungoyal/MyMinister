require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Constituency do
  context 'associations' do
    
    it "belongs to a state" do
      state = Factory.build(:state)
      constituency = Constituency.new :state => state
      constituency.state.should == state
    end
  end
end