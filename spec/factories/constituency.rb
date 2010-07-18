Factory.define :constituency do |f|
  f.name  "Ajmer"
  f.state {|state| state.association(:state)}
end