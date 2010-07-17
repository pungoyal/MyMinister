require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberOfParliament do
  context 'associations' do
    it "belong to a party, constituency" do
      party = Factory.build(:party)
      constituency = Factory.build(:constituency)
      minister = MemberOfParliament.new :party => party, :constituency => constituency
      
      minister.party.should == party
      minister.constituency.should == constituency
    end
    
    it "has 1 minister profile" do
      minister_profile = Factory.build(:member_of_parliament_profile)
      minister = MemberOfParliament.new :member_of_parliament_profile => minister_profile
      
      minister.member_of_parliament_profile.should eql minister_profile
    end
  end
end