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
    no_of_mps = 544 #excludes the deceased Mr.Digvijay Singh
    raise "MemberOfParliament count expected to be #{no_of_mps} but was #{Mp.count}" unless Mp.count == no_of_mps
    raise "MemberOfParliamentProfile count expected to be #{no_of_mps} but was #{MpProfile.count}" unless MpProfile.count == no_of_mps
    raise "Party count expected to be 38 but was #{Party.count}" unless Party.count == 38
    raise "Constituency count expected to be #{no_of_mps} but was #{Constituency.count}" unless Constituency.count == no_of_mps
    raise "State count expected to be 35 but was #{State.count}" unless State.count == 35

    puts "--Import finished on #{Rails.env}--"
  end
end
