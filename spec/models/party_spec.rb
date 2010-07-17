require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Party do
  context "associations" do
    it "should have many member of parliaments" do
      member_of_parliaments = [Factory.build(:member_of_parliament), Factory.build(:member_of_parliament)]
      party = Party.new :member_of_parliaments => member_of_parliaments
      party.member_of_parliaments.should == member_of_parliaments
    end
  end
  
  context "find_or_create" do
    it "should find when it exists" do
      party = Factory.create(:party)
      lambda {
        party_found = Party.find_or_create :name => party.name
        party_found.should == party
      }.should_not change(Party, :count)
    end
    
    it "should create when it does not exist" do
      lambda {
        party = Party.find_or_create :name => "foobar"
      }.should change(Party, :count)
    end
  end
end