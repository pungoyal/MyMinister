class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  def cache_action
    response.headers['Cache-Control'] = "public, max-age=#{60*60*24*100}"
    response.headers.delete('cookie')
  end
  
end
