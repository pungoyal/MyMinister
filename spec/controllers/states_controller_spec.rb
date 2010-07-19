require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatesController do
  
  context "index" do
    it "should list all states when format is json" do
      state_one = Factory.create(:state)
      state_two = Factory.create(:state)
      
      get :index, :format => :json
      
      states = ActiveSupport::JSON.decode(response.body)
      states.should have(2).things
      states.first["name"].should == state_one.name
      states.last["name"].should == state_two.name
    end

    it "should list all states when format is xml" do
      state_one = Factory.create(:state)
      state_two = Factory.create(:state)
      
      get :index, :format => :xml
      
      states =  Hash.from_xml(response.body)["states"]
      states.should have(2).things
      states.first["name"].should == state_one.name
      states.last["name"].should == state_two.name
    end
  end
  
end