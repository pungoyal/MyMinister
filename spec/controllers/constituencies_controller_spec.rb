require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ConstituenciesController do
  context "index" do
    it "should list all constituencies when format is json" do
      constituency_one = Factory.create(:constituency, :name => "Foo")
      constituency_two = Factory.create(:constituency, :name => "Bar")
      
      get :index, :format => :json
      
      constituencies = ActiveSupport::JSON.decode(response.body)
      constituencies.should have(2).things
      constituencies.first["id"].should == constituency_one.id
      constituencies.first["name"].should == constituency_one.name
      constituencies.last["id"].should == constituency_two.id
      constituencies.last["name"].should == constituency_two.name
    end

    it "should list all constituencies when format is xml" do
      constituency_one = Factory.create(:constituency, :name => "Foo")
      constituency_two = Factory.create(:constituency, :name => "Bar")
      
      get :index, :format => :xml
      
      constituencies = Hash.from_xml(response.body)["constituencies"]
      constituencies.should have(2).things
      constituencies.first["id"].should == constituency_one.id
      constituencies.first["name"].should == constituency_one.name
      constituencies.last["id"].should == constituency_two.id
      constituencies.last["name"].should == constituency_two.name
    end
    
    it "should list constituencies for specified state" do
      state = Factory.create(:state)
      constituency_one = Factory.create(:constituency, :name => "Foo", :state => state)
      constituency_two = Factory.create(:constituency, :name => "Bar", :state => Factory.create(:state))
      
      get :index, :state_id => state.id, :format => :json
      
      constituencies = ActiveSupport::JSON.decode(response.body)
      constituencies.should have(1).things
      constituencies.first["name"].should == constituency_one.name
    end
  end
end