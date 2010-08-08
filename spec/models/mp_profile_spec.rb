require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MpProfile do
  context 'attributes' do
    it "should save and load" do
      params = {:fathers_name => "Late Shri Rajesh Pilot", 
                :positions => [ {:period => '12 May 2009', :name => 'FooBar'},
                                {:period => '13 May 2010', :name => 'FooBarBar'}],
                :activity => {:sports_and_clubs => 'Golf', :countries_visited => 'SriLanka'}
               }
      
      mp = Factory.create(:mp, :mp_profile => MpProfile.new(params))
      
      profile = mp.mp_profile

      profile.positions.should_not be_nil
      
      loaded_profile = MpProfile.get(profile.id)
      
      loaded_profile.should_not be_nil
      loaded_profile.fathers_name.should == "Late Shri Rajesh Pilot"
      
      loaded_profile.positions.should_not be_nil
      loaded_profile.positions.should have(2).things
      loaded_profile.positions.first.period.should == "12 May 2009"
      loaded_profile.positions.first.name.should == "FooBar"
      loaded_profile.positions.last.period.should == "13 May 2010"
      loaded_profile.positions.last.name.should == "FooBarBar"

      loaded_profile.activity.sports_and_clubs.should == "Golf"
      loaded_profile.activity.countries_visited.should == "SriLanka"
    end
  end
end
