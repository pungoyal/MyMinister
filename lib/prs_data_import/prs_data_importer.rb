require 'faster_csv'

class PrsDataImporter
  PRS_FILE = "MPTrack-Aug4th.csv"
  CONSTITUENCY_ALIASES = {"Khushi Nagar" => "Kushi Nagar", "Ramanthapuram" => "Ramanathapuram", "Krishnanagar" => "Krishnagar"}
  
  def start
    puts "Importing: #{PRS_FILE}"
    mp_data = FasterCSV.read(File.join(File.dirname(__FILE__), "/../../data/prs_data/#{PRS_FILE}"))     
    mp_data.drop(1).each do |data|
      constituency = CONSTITUENCY_ALIASES[data[5]] ||  data[5]
      if constituency.blank?
        puts "No constituency specified for MP: #{data[0]}"
      else
        state = State.first(:name.like => data[4])
        cs = state.constituencies.all(:name.like => constituency) + 
             state.constituencies(:name.like => "#{constituency}(SC)") + Constituency.all(:name.like => "#{constituency} (SC)") + 
             state.constituencies(:name.like => "#{constituency}(ST)") + Constituency.all(:name.like => "#{constituency} (ST)")
      
        puts "'#{data[5]}' not found(#{cs.size})" if cs.size !=1
      end
    end
  end
end
