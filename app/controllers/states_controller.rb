class StatesController < ApplicationController
  after_filter :cache_action, :only => [:index]

  def index
    states = ::State.all
    respond_to do |format|
      format.json {render :json => {:model => states.to_json}}
      format.xml {render :json => states.to_xml}
    end
  end

end