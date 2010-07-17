require "#{File.dirname(__FILE__)}/mp_data_scraper"

class MpDataImporter
  def start
    mps_by_state = MpDataScraper.new.import
    no_of_mps_scraped = mps_by_state.collect{|state|state[:mps].size}.inject{|sum, no| sum + no}
    p "Scraped #{no_of_mps_scraped} member of parliaments"
    mps_by_state.each do |state|
      State.create(:name => state[:name], :no_of_mps => state[:no_of_mps].to_i)
      state[:mps].each do |mp|
        MemberOfParliament.create(
          :name => mp[:name], 
          :constituency => Constituency.create(:name => mp[:constituency]),
          :party => Party.find_or_create(:name => mp[:party])
        )
      end
    end
  end
end
