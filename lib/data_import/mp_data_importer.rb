require "#{File.dirname(__FILE__)}/mp_data_scraper"

class MpDataImporter
  def start
    mps_by_state = MpDataScraper.new.import
    no_of_mps_scraped = mps_by_state.collect{|state|state[:mps].size}.inject{|sum, no| sum + no}
    puts "--Scraped #{no_of_mps_scraped} member of parliaments--"
    mps_by_state.each do |state|
      state[:mps].each do |mp|
          Mp.create(
          :name => mp[:name], 
          :constituency => Constituency.create(
            :name => mp[:constituency], 
            :state => State.find_or_create({:name => state[:name], :no_of_mps => state[:no_of_mps].to_i})),
          :party => Party.find_or_create(:name => mp[:party]),
          :mp_profile => MpProfile.create(mp[:mp_profile])
        )
      end
    end
    verify
  end
  
  def verify
    raise "MemberOfParliament count expected to be 543 but was #{Mp.count}" unless Mp.count == 543
    raise "MemberOfParliamentProfile count expected to be 543 but was #{MpProfile.count}" unless MpProfile.count == 543
    raise "Party count expected to be 38 but was #{Party.count}" unless Party.count == 38
    raise "Constituency count expected to be 543 but was #{Constituency.count}" unless Constituency.count == 543
    raise "State count expected to be 35 but was #{State.count}" unless State.count == 35
    
    puts "--Done--"
  end
end
