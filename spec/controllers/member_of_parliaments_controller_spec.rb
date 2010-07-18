require 'csv' #Hack for making dm-serializer behave

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberOfParliamentsController do
  
  context "index" do
    it "should return all Member Of Parliament in json format" do
      mp_one = Factory.create(:member_of_parliament, :name => "Foo")
      mp_two = Factory.create(:member_of_parliament, :name => "Bar")      

      get :index, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(2).things
      mps.first["id"].should == mp_one.id
      mps.first["name"].should == mp_one.name
      mps.last["id"].should == mp_two.id
      mps.last["name"].should == mp_two.name
    end
    
    it "should return all Member Of Parliament in xml format" do
      mp_one = Factory.create(:member_of_parliament, :name => "Foo")
      mp_two = Factory.create(:member_of_parliament, :name => "Bar")      
      
      get :index, :format => :xml
      
      mps = Hash.from_xml(response.body)["member_of_parliaments"]
      
      mps.should have(2).things
      mps.first["id"].should == mp_one.id
      mps.first["name"].should == mp_one.name
      mps.last["id"].should == mp_two.id
      mps.last["name"].should == mp_two.name
    end
    
  end
  
  context "show" do
    it "should return the specified Member Of Parliament as json" do
      mp = Factory.create(:member_of_parliament, :name => "Foo")
      get :show, :id => mp.id, :format => :json
      
      mp_response = ActiveSupport::JSON.decode(response.body)
      
      mp_response["name"].should == "Foo"
      mp_response["party_id"].should == mp.party_id
      mp_response["constituency_id"].should == mp.constituency_id
    end
    
    it "should return the specified Member of Parliament as xml" do
      mp = Factory.create(:member_of_parliament, :name => "Foo")
      get :show, :id => mp.id, :format => :xml      
      
      mp_response = Hash.from_xml(response.body)["member_of_parliament"]
      mp_response["name"].should == "Foo"
      mp_response["party_id"].should == mp.party_id
      mp_response["constituency_id"].should == mp.constituency_id
    end
  end
end