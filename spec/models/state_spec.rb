require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe State do
  context "associations" do
    it "should have many constituencies" do
      constituencies = [Factory.build(:constituency), Factory.build(:constituency)]
      state = State.new :constituencies => constituencies
      state.constituencies.should == constituencies
    end
  end
end