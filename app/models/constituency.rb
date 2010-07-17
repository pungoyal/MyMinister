class Constituency
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  
  belongs_to :state
  has 1, :member_of_parliament
end