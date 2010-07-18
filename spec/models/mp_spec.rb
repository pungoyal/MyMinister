require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp do
  context 'associations' do
    it "belong to a party, constituency" do
      party = Factory.build(:party)
      constituency = Factory.build(:constituency)
      mp = Mp.new :party => party, :constituency => constituency
      
      mp.party.should == party
      mp.constituency.should == constituency
    end
    
    it "has 1 mp profile" do
      mp_profile = Factory.build(:mp_profile)
      mp = Mp.new :mp_profile => mp_profile
      
      mp.mp_profile.should eql mp_profile
    end
  end
end