require "#{File.dirname(__FILE__)}/../data_import/mp_data_importer"
require "#{File.dirname(__FILE__)}/../prs_data_import/prs_data_importer"

namespace :data do
  desc "Import information on members of parliament(this is a one time process)"
  task :import  => [:environment, :'db:automigrate'] do
    MpDataImporter.new.start
  end
  
  desc "Updates existing data with prs data located at RAILS_ROOT/data/prs_data/MPTrack-Date.csv"  
  task :update_from_prs => [:environment, :'db:autoupgrade'] do
    PrsDataImporter.new.start
  end
end