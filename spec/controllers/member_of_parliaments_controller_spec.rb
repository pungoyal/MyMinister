require 'csv' #Hack for making dm-serializer behave

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberOfParliamentsController do
  
  context "index" do
    it "should return all Members Of Parliament in json format" do
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
    
    it "should return all Members Of Parliament in xml format" do
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
  
  context "index with constituency specified" do
    it "should return Members of Parliament of specified constituency" do
      constituency = Factory.create(:constituency)
      mp_in_constituency = Factory.create(:member_of_parliament, :name => "Foo", :constituency => constituency)
      mp_of_another_constituency = Factory.create( :member_of_parliament, 
                                                   :name => "Bar", 
                                                   :constituency => Factory.create(:constituency))
      
      get :index, :constituency_id => constituency.id, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(1).thing
      mps.first["name"].should == mp_in_constituency.name
    end
  end

  context "index with state specified" do
    it "should return Members of Parliament of specified state" do
      state = Factory.create(:state)
      constituency = Factory.create(:constituency, :state => state)
      mp_in_state = Factory.create(:member_of_parliament, :name => "Foo" , :constituency => constituency)
      mp_of_another_state = Factory.create(:member_of_parliament, :name => "Bar", :constituency => Factory.create(:constituency))
      
      get :index, :state_id => state.id, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(1).thing
      mps.first["name"].should == "Foo"
    end
  end

  context "index with party specified" do
    it "should return Members of Parliament of specified state" do
      party = Factory.create(:party)
      mp_in_party = Factory.create(:member_of_parliament, :name => "Foo" , :party => party)
      mp_of_another_party = Factory.create(:member_of_parliament, :name => "Bar", :party => Factory.create(:party))
      
      get :index, :party_id => party.id, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(1).thing
      mps.first["name"].should == "Foo"
    end
  end
  
  context "show" do
    it "should return the specified Member Of Parliament as json" do
      mp = Factory.create(:member_of_parliament, :name => "Foo")
      get :show, :id => mp.id, :format => :json
      
      mp_response = ActiveSupport::JSON.decode(response.body)
      
      mp_response["name"].should == mp.name
      mp_response["party_id"].should == mp.party_id
      mp_response["party"]["name"].should == mp.party.name
      mp_response["constituency_id"].should == mp.constituency_id
      mp_response["constituency"]["name"].should == mp.constituency.name
    end
    
    it "should return the specified Member of Parliament as xml" do
      mp = Factory.create(:member_of_parliament, :name => "Foo")
      get :show, :id => mp.id, :format => :xml
      
      mp_response = Hash.from_xml(response.body)["member_of_parliament"]

      mp_response["name"].should == mp.name
      mp_response["party_id"].should == mp.party_id
      mp_response["party"]["name"].should == mp.party.name
      mp_response["constituency_id"].should == mp.constituency_id
      mp_response["constituency"]["name"].should == mp.constituency.name
    end
  end
end