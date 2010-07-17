class MemberOfParliament
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  belongs_to :party
  belongs_to :constituency
  
  has 1, :member_of_parliament_profile
end