class State
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :no_of_mps, Integer
  
  has n, :constituencies
  
  def self.find_or_create state_params
    state = ::State.first(:name => state_params[:name])
    state.nil? ? ::State.create(state_params) : state
  end
end