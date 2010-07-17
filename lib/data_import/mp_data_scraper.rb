require 'rubygems'
require 'uri'
require 'nokogiri'
require 'open-uri'
require "#{File.dirname(__FILE__)}/mp_detail_scraper"

class MpDataScraper

  STATE_LISTS_URL = "http://164.100.47.132/LssNew/Members/Statewiselist.aspx"
  STATE_DETAILS_URL = "http://164.100.47.132/LssNew/Members/"

  def states
    @states ||= []
  end

  def import
    import_state
    states
  end

  def import_state
    doc = Nokogiri::HTML(open(STATE_LISTS_URL))
    [1,2].each do |state_type|
      doc.css("table#ctl00_ContPlaceHolderMain_Statewiselist1_dg#{state_type} tr").drop(1).each do |state|
        state_elements = state.css('td.griditem')
        states << {
          :name  => state_elements[1].text.strip,
          :no_of_mps  =>  state_elements[2].text.strip,
          :mps  => import_mps(state_elements[1])
        }
      end
    end
  end

  def import_mps state
    doc = Nokogiri::HTML(open(STATE_DETAILS_URL + URI::escape(state.css('a').first["href"])))
    doc.css('table#ctl00_ContPlaceHolderMain_Statedetail1_dg1 tr').drop(1).collect do |mp|
      mp_elements = mp.css('td.griditem')
      {
        :constituency  => mp_elements[1].text.strip,
        :name  =>  mp_elements[2].text.strip,
        :party  => mp_elements[3].text.strip,
        :mp_details => MPDetailScraper.new.import(mp_elements[2].css('a').first['href'])
      }
    end
  end
  
end
