class Party
  include DataMapper::Resource
  
  property :name, String
  property :id, Serial
  
  has n, :mps
  
  def self.find_or_create party_params
    party = Party.first(:name => party_params[:name])
    party.nil? ? Party.create(party_params) : party
  end
  
end