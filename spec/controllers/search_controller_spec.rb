require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do
  context "search by name" do
    it "should list when search type is MP" do
      mp_one = Factory.create(:mp, :name => "FooBar")
      mp_two = Factory.create(:mp, :name => "BarBaz")
      mp_three = Factory.create(:mp, :name => "BazFoo")
      
      get :index, :type => SearchController::SEARCH_TYPES[:mp], :name => "Bar", :format => :json

      search_results = ActiveSupport::JSON.decode(response.body)
      
      search_results.should have(2).things
      search_results.first["name"].should == "FooBar"
      search_results.last["name"].should == "BarBaz"
    end
    
    it "should list when search type is Party" do
      party_one = Factory.create(:party, :name => "FooBar")
      party_two = Factory.create(:party, :name => "BarBaz")
      party_three = Factory.create(:party, :name => "BazFoo")

      get :index, :type => SearchController::SEARCH_TYPES[:party], :name => "Bar", :format => :json

      search_results = ActiveSupport::JSON.decode(response.body)
      
      search_results.should have(2).things
      search_results.first["name"].should == "FooBar"
      search_results.last["name"].should == "BarBaz"
    end

    it "should list when search type is Constituency" do
      constituency_one = Factory.create(:constituency, :name => "FooBar")
      constituency_two = Factory.create(:constituency, :name => "BarBaz")
      constituency_three = Factory.create(:constituency, :name => "BazFoo")

      get :index, :type => SearchController::SEARCH_TYPES[:constituency], :name => "Bar", :format => :json

      search_results = ActiveSupport::JSON.decode(response.body)
      
      search_results.should have(2).things
      search_results.first["name"].should == "FooBar"
      search_results.last["name"].should == "BarBaz"
    end
    
    it "should be empty when no matches found" do
      get :index, :type => SearchController::SEARCH_TYPES[:constituency], :name => "Bar", :format => :json

      search_results = ActiveSupport::JSON.decode(response.body)
      search_results.should be_empty
    end
  end
end
