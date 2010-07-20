class MpProfile
  include DataMapper::Resource

  property :id, Serial
  property :fathers_name, Text
  property :mothers_name, Text
  property :date_of_birth, Text
  property :place_of_birth, Text
  property :martial_status, String
  property :date_of_marriage, String
  property :spouse_name, Text
  property :no_of_sons, String
  property :no_of_daughters, String
  property :educational_qualifications, Text
  property :profession, Text
  property :permanent_address, Text
  property :present_address, Text
  property :email, Text
  
  property :positions, Yaml
  property :activity, Yaml

  belongs_to :mp
  
  def positions= position_params
    @positions = position_params.collect do |position_param|
      Position.new position_param
    end
  end
  
  def activity= activity_param
    @activity = Activity.new activity_param
  end
  
end