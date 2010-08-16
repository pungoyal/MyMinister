class StatesController < ApplicationController
  after_filter :cache_action, :only => [:index]

  def index
    states = ::State.all
    respond_to do |format|
      format.json {render :json => states.to_json(:methods => [:state_statistic])}
      format.xml {render :json => states.to_xml(:methods => [:state_statistic])}
    end
  end

end