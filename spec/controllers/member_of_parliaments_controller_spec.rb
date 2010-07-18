require 'csv' #Hack for making dm-serializer behave

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberOfParliamentsController do
  
  context "index" do
    
    before(:each) do
      Factory.create(:member_of_parliament, :name => "Foo")
      Factory.create(:member_of_parliament, :name => "Bar")      
    end
       
    it "should return all Member Of Parliament in json format" do
      get :index, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(2).things
      mps.first["name"].should == "Foo"
      mps.last["name"].should == "Bar"
    end
    
    it "should return all Member Of Parliament in xml format" do
      get :index, :format => :xml
      
      mps = Hash.from_xml(response.body)["member_of_parliaments"]
      
      mps.should have(2).things
      mps.first["name"].should == "Foo"
      mps.last["name"].should == "Bar"
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