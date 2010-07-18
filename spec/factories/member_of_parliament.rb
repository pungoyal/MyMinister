Factory.define :member_of_parliament do |f|
  f.name "Pilot,Shri Sachin"
  f.party {|party| party.association(:party)}
  f.constituency {|constituency| constituency.association(:constituency)}
end
