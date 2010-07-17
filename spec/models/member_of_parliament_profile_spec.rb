require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberOfParliamentProfile do
  context 'attributes' do
    it "should save and load" do
      params = {:fathers_name => "Late Shri Rajesh Pilot", 
                :positions => [ {:period => '12 May 2009', :name => 'FooBar'},
                                {:period => '13 May 2010', :name => 'FooBarBar'}],
                :activity => {:sports_and_clubs => 'Golf', :countries_visited => 'SriLanka'}
               }
      
      profile = MemberOfParliamentProfile.create params
      
      profile = profile.reload
      
      profile.fathers_name.should == "Late Shri Rajesh Pilot"

      profile.positions.should have(2).things
      profile.positions.first.period.should == "12 May 2009"
      profile.positions.first.name.should == "FooBar"
      profile.positions.last.period.should == "13 May 2010"
      profile.positions.last.name.should == "FooBarBar"
      
      profile.activity.sports_and_clubs.should == "Golf"
      profile.activity.countries_visited.should == "SriLanka"
    end
  end
end
