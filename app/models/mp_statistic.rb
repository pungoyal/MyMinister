class MpStatistic 
  include DataMapper::Resource

  property :id, Serial
  property :debates, Integer
  property :private_member_bills, Integer
  property :questions, Integer
  property :attendance, Integer
  
  belongs_to :mp
  
end