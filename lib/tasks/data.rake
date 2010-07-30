require "#{File.dirname(__FILE__)}/../data_import/mp_data_importer"

namespace :data do
  desc "Import information on members of parliament"
  task :import  => [:environment, :'db:automigrate'] do
    MpDataImporter.new.start
  end
end