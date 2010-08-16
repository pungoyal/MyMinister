class StateStatistic
  
  include DataMapper::Resource

  property :id, Serial
  property :debates, Float
  property :private_member_bills, Float
  property :questions, Float
  property :attendance, Float

  belongs_to :state
end