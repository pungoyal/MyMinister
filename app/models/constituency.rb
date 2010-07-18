class Constituency
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  
  belongs_to :state
  has 1, :mp
end