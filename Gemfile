source 'http://gemcutter.org'

gem 'rails', '3.0.0.beta4'

gem 'data_objects', '0.10.2'

gem 'dm-core', '1.0.0'
gem 'dm-types', '1.0.0'
gem 'dm-validations', '1.0.0'
gem 'dm-constraints', '1.0.0'
gem 'dm-aggregates', '1.0.0'
gem 'dm-timestamps', '1.0.0'
gem 'dm-migrations', '1.0.0'
gem 'dm-observer', '1.0.0'
gem 'dm-rails', '1.0.0'
gem 'dm-serializer', '1.0.0'
gem 'rails3-generators'
gem 'sanitize'
gem 'fastercsv'

group :test, :development do
  gem 'dm-transactions'
  gem 'rspec', '>= 2.0.0.beta.17'
  gem "rspec-rails", ">= 2.0.0.beta.17"
  gem 'factory_girl_rails' 
  gem 'dm-sqlite-adapter'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :production do
  gem 'dm-postgres-adapter'
  gem 'pg'
end