require 'faster_csv'

# Imports data downloaded from http://www.prsindia.org/index.php?name=mptracklok

class PrsDataImporter
  PRS_FILE = "MPTrack-Aug4th.csv"
  CONSTITUENCY_ALIASES = {"Khushi Nagar" => "Kushi Nagar", "Ramanthapuram" => "Ramanathapuram", "Krishnanagar" => "Krishnagar"}
  
  def start
    puts "Importing: #{PRS_FILE}"
    MpStatistic.destroy
    StateStatistic.destroy
    
    mp_data = FasterCSV.read(File.join(File.dirname(__FILE__), "/../../data/prs_data/#{PRS_FILE}"))     
    mp_data.drop(1).each do |data|
      constituency = find_constituency data
      create_statistic constituency, data if constituency
    end
    verify
  end
  
  private 
  
  def find_constituency data
    constituency = CONSTITUENCY_ALIASES[data[5]] ||  data[5]
    if constituency.blank?
      # raise "No constituency specified for MP: #{data[0]}"
      puts "No constituency specified for MP: #{data[0]}"
    else
      state = State.first(:name.like => data[4])
      cs = state.constituencies.all(:name.like => constituency) + 
           state.constituencies(:name.like => "#{constituency}(SC)") + Constituency.all(:name.like => "#{constituency} (SC)") + 
           state.constituencies(:name.like => "#{constituency}(ST)") + Constituency.all(:name.like => "#{constituency} (ST)")
      # raise "Incorrect no. of constituencies '#{data[5]}' - #{cs.size}" if cs.size !=1
      puts "Incorrect no. of constituencies '#{data[5]}' - #{cs.size}" if cs.size !=1
      return cs.first
    end    
  end
  
  def create_statistic constituency, data
    constituency.mp.update(:mp_statistic=> {:debates => data[11].to_i, :private_member_bills => data[12].to_i, 
                           :questions => data[13].to_i, :attendance => data[14].delete("%").to_i})
                           
    valid = constituency.state.update(:state_statistic => {:debates => data[20].to_f, :private_member_bills => data[21].to_f,
                               :questions => data[22].to_f, :attendance => data[23].delete("%").to_f})
    raise "#{constituency.state.state_statistic}" unless valid
  end
  
  def verify
    raise "verification failed: expected 543 MpStatistics, found #{MpStatistic.count}" if MpStatistic.count != 542
    raise "verification failed: expected 543 StateStatistics, found #{StateStatistic.count}" if StateStatistic.count != 542
  end
end
