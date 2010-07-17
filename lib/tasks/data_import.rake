require "#{File.dirname(__FILE__)}/../data_import/mp_data_importer"

namespace :data_import do
  desc "Import Member of Parliament data"
  task :start  => [:environment, :'db:automigrate'] do
    MpDataImporter.new.start
  end
end