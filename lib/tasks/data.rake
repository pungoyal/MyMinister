require "#{File.dirname(__FILE__)}/../data_import/mp_data_importer"

namespace :data do
  desc "Import information on members of parliament"
  task :import  => [:environment, :'db:automigrate'] do
    MpDataImporter.new.start
  end
  
  desc "Updates existing data with prs data at RAILS_ROOT/data/prs_data/MPTrack-Date.csv"  
  task :import_prs_data => [:environment] do
    PrsDataImporter.new.start
  end
end