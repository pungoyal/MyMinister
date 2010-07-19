require 'csv' #Hack for making dm-serializer behave

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MpsController do
  
  context "index" do
    it "should return all Members Of Parliament in json format" do
      mp_one = Factory.create(:mp, :name => "Foo")
      mp_two = Factory.create(:mp, :name => "Bar")      

      get :index, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(2).things
      mps.first["id"].should == mp_one.id
      mps.first["name"].should == mp_one.name
      mps.last["id"].should == mp_two.id
      mps.last["name"].should == mp_two.name
    end
    
    it "should return all Members Of Parliament in xml format" do
      mp_one = Factory.create(:mp, :name => "Foo")
      mp_two = Factory.create(:mp, :name => "Bar")      
      
      get :index, :format => :xml
      
      mps = Hash.from_xml(response.body)["mps"]
      
      mps.should have(2).things
      mps.first["id"].should == mp_one.id
      mps.first["name"].should == mp_one.name
      mps.last["id"].should == mp_two.id
      mps.last["name"].should == mp_two.name
    end
    
  end
  
  context "show with constituency specified" do
    it "should return Member of Parliament for specified constituency" do
      constituency = Factory.create(:constituency)
      mp_in_constituency = Factory.create(:mp, :name => "Foo", :constituency => constituency)
      mp_of_another_constituency = Factory.create( :mp, 
                                                   :name => "Bar", 
                                                   :constituency => Factory.create(:constituency))
      
      get :show, :constituency_id => constituency.id, :format => :json
      
      mp_response = ActiveSupport::JSON.decode(response.body)
      mp_response["name"].should == mp_in_constituency.name
    end
  end

  context "index with state specified" do
    it "should return Members of Parliament of specified state" do
      state = Factory.create(:state)
      constituency = Factory.create(:constituency, :state => state)
      party = Factory.create(:party)
      mp_in_state = Factory.create(:mp, :name => "Foo" , :constituency => constituency, :party => party)
      mp_of_another_state = Factory.create(:mp, :name => "Bar", :constituency => Factory.create(:constituency))
      
      get :index, :state_id => state.id, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(1).thing
      mps.first["name"].should == "Foo"
      mps.first["constituency"]["name"] == constituency.name
      mps.first["party"]["name"] == party.name
    end
  end

  context "index with party specified" do
    it "should return Members of Parliament of specified state" do
      party = Factory.create(:party)
      mp_in_party = Factory.create(:mp, :name => "Foo" , :party => party)
      mp_of_another_party = Factory.create(:mp, :name => "Bar", :party => Factory.create(:party))
      
      get :index, :party_id => party.id, :format => :json
      
      mps = ActiveSupport::JSON.decode(response.body)
      mps.should have(1).thing
      mps.first["name"].should == "Foo"
    end
  end
  
  context "show" do
    it "should return the specified Member Of Parliament as json" do
      mp = Factory.create(:mp, :name => "Foo", :mp_profile => MpProfile.create(:fathers_name => "foobar"))
      get :show, :id => mp.id, :format => :json
      
      mp_response = ActiveSupport::JSON.decode(response.body)
      
      mp_response["name"].should == mp.name
      mp_response["party_id"].should == mp.party_id
      mp_response["party"]["name"].should == mp.party.name
      mp_response["constituency_id"].should == mp.constituency_id
      mp_response["constituency"]["name"].should == mp.constituency.name
      mp_response["mp_profile"]["fathers_name"].should == mp.mp_profile.fathers_name
    end
    
    it "should return the specified Member of Parliament as xml" do
      mp = Factory.create(:mp, :name => "Foo", :mp_profile => MpProfile.create(:fathers_name => "foobar"))
      get :show, :id => mp.id, :format => :xml
      
      mp_response = Hash.from_xml(response.body)["mp"]

      mp_response["name"].should == mp.name
      mp_response["party_id"].should == mp.party_id
      mp_response["party"]["name"].should == mp.party.name
      mp_response["constituency_id"].should == mp.constituency_id
      mp_response["constituency"]["name"].should == mp.constituency.name
      mp_response["mp_profile"]["fathers_name"].should == mp.mp_profile.fathers_name
    end
  end
end