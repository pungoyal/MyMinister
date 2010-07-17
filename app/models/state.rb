class State
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :no_of_mps, Integer
  
  has n, :constituencies
end