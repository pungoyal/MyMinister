require ::File.expand_path('../config/environment',  __FILE__)

require 'rack'
require 'rack/contrib'

use Rack::Profiler if ENV['RACK_ENV'] == 'development'
use Rack::JSONP

run Myminister::Application
