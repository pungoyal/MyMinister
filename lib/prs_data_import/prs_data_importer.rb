require 'faster_csv'

class PrsDataImporter
  PRS_FILE = "MPTrack-Aug4th.csv"
  
  def start
    puts "Importing: #{PRS_FILE}"
    array_of_arrays = FasterCSV.read(File.join(File.dirname(__FILE__), "/../../data/prs_data/#{PRS_FILE}"))     
    p array_of_arrays.size
  end
end

PrsDataImporter.new.start