require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sanitize'

class MPDetailScraper

  MP_DETAIL_URL = "http://164.100.47.132/LssNew/Members/"
  
  MP_DETAIL_ELEMENTS = {
    :fathers_name => "Father's Name",
    :mothers_name => "Mother's Name",
    :date_of_birth => "Date of Birth",
    :place_of_birth => "Place of Birth",
    :martial_status => "Marital Status",
    :date_of_marriage => "Date of Marriage",
    :spouse_name => "Spouse's Name",
    :no_of_sons => "No. of Sons",
    :no_of_daughters => "No.of Daughters",
    :educational_qualifications => "Educational Qualifications",
    :profession => "Profession",
    :permanent_address => "Permanent Address",
    :present_address => "Present Address"
  }
  
  MP_DETAIL_ACTIVITIES = {
    :social_and_cultural_activities => "Social And Cultural Activities",
    :literary_artistic_and_scientific_accomplishments => "Literary Artistic & Scientific Accomplishments",
    :special_interests => "Special Interests",
    :favourite_pastime_and_recreation => "Favourite Pastime and Recreation",
    :sports_and_clubs => "Sports and Clubs",
    :countries_visited => "Countries Visited",
    :other_information => "Other Information"
  }
  
  MP_OTHER = {
    :email => "Email Address :",
    :photo => "Photo"
  }
  
  def import mp_param
    url = MP_DETAIL_URL + mp_param
    doc = Nokogiri::HTML(open(url))
    puts "Importing: #{url}"
    mp_detail = parse_mp_bio doc
    mp_detail[:positions] = parse_mp_positions doc
    mp_detail[:activity] = parse_mp_activities doc
    mp_detail
  end
  
  def parse_mp_bio doc
    mp_detail = {}
    mp_detail_elements = doc.css('table#ctl00_ContPlaceHolderMain_Bioprofile1_DataGrid2 table tr').collect{|d|d.text.strip}
    MP_DETAIL_ELEMENTS.each do |element_key, element_label|
      mp_detail_node_text = mp_detail_elements.find{|element| element.include?(element_label)}
      mp_detail_label_and_value = mp_detail_node_text.to_s.split(element_label)
      mp_detail_value = mp_detail_label_and_value.last.gsub(/\s+/, " ").strip if mp_detail_label_and_value.size == 2
      mp_detail[element_key] = Sanitize.clean(mp_detail_value) if mp_detail_value
    end
    mp_email_node = doc.css('table#ctl00_ContPlaceHolderMain_Bioprofile1_Datagrid1 table tr').find{|d|d.text.strip.include?(MP_OTHER[:email])}
    if mp_email_node
      mp_email_label_and_value = mp_email_node.to_s.split(MP_OTHER[:email])
      mp_detail[:email] = Sanitize.clean(mp_email_label_and_value.last.gsub(/\s+/, " ").strip)
    end
    mp_detail[:photo] = doc.css("#ctl00_ContPlaceHolderMain_Bioprofile1_Image1").first['src']
    mp_detail
  end
  
  def parse_mp_positions doc
    mp_position_elements = doc.css('table#ctl00_ContPlaceHolderMain_Bioprofile1_Datagrid3 table tr')
    mp_position_elements.inject([]) do |mp_positions, element|
      rows = element.css('td')
      mp_positions << {:period => Sanitize.clean(rows.first.text.strip), :name => Sanitize.clean(rows.last.text.strip)}
    end
  end

  def parse_mp_activities doc
    mp_activities = {}
    mp_activity_elements = doc.css('table#ctl00_ContPlaceHolderMain_Bioprofile1_Datagrid4 table tr')
    mp_activity_values= mp_activity_elements.collect{|element| element.text.strip}.select{|element| !element.empty?}
    MP_DETAIL_ACTIVITIES.each do |key, value|
      mp_activities[key] = Sanitize.clean(mp_activity_values[mp_activity_values.index(value)+1]) unless mp_activity_values.index(value).nil?
    end
    mp_activities
  end
end

# p MPDetailScraper.new.import "Biography.aspx?mpsno=438"