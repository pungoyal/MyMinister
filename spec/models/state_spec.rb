require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe State do
  context "associations" do
    it "should have many constituencies" do
      constituencies = [Factory.build(:constituency), Factory.build(:constituency)]
      state = State.new :constituencies => constituencies
      state.constituencies.should == constituencies
    end
  end

  context "find_or_create" do
    it "should find when it exists" do
      state = Factory.create(:state)
      lambda {
        state_found = State.find_or_create(:name => state.name)
        state_found.should == state
      }.should_not change(State, :count)
    end
    
    it "should create when it does not exist" do
      lambda {
        state = State.find_or_create :name => "foobar"
      }.should change(State, :count)
    end
  end
  
end