source 'http://gemcutter.org'

gem 'rails', '3.0.0.beta4'

gem 'data_objects', '0.10.2'

gem 'dm-core'
gem 'dm-types'
gem 'dm-validations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-observer'
gem 'dm-rails'
gem 'dm-serializer'
gem 'rails3-generators'

group :test, :development do
  gem 'dm-transactions'
  gem 'rspec', '>= 2.0.0.beta.17'
  gem "rspec-rails", ">= 2.0.0.beta.17"
  gem 'factory_girl_rails'
  gem 'dm-sqlite-adapter'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :production do
  'dm-postgres-adapter'
end