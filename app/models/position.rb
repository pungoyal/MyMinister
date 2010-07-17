class Position
  attr_accessor :name
  attr_accessor :period
  
  def initialize params
    params.each do |attribute, value|
      send "#{attribute}=", value
    end
  end
  
end