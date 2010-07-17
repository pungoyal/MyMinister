class MemberOfParliamentProfile
  include DataMapper::Resource
  
  property :id, Serial
  property :fathers_name, String
  
  belongs_to :member_of_parliament
end