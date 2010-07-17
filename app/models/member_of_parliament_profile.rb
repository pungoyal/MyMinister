class MemberOfParliamentProfile
  include DataMapper::Resource

  property :id, Serial
  property :fathers_name, String
  property :mothers_name, String
  property :date_of_birth, String
  property :place_of_birth, String
  property :martial_status, String
  property :date_of_marriage, String
  property :spouse_name, String
  property :no_of_sons, String
  property :no_of_daughters, String
  property :educational_qualifications, String
  property :profession, String
  property :permanent_address, String
  property :present_address, String
  
  property :positions, Yaml
  property :activity, Yaml

  belongs_to :member_of_parliament
  
  def positions= position_params
    @positions = position_params.collect do |position_param|
      Position.new position_param
    end
  end
  
  def activity= activity_param
    @activity = Activity.new activity_param
  end
  
end