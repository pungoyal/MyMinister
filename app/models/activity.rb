class Activity
  attr_accessor :social_and_cultural_activities
  attr_accessor :literary_artistic_and_scientific_accomplishments
  attr_accessor :special_interests
  attr_accessor :favourite_pastime_and_recreation
  attr_accessor :sports_and_clubs
  attr_accessor :countries_visited
  attr_accessor :other_information
  
  def initialize params
    params.each do |attribute, value|
      send "#{attribute}=", value
    end
  end
  
end