class StatesController < ApplicationController

  def index
    states = ::State.all
    respond_to do |format|
      format.json {render :json => states.to_json}
      format.xml {render :json => states.to_xml}
    end
  end

end