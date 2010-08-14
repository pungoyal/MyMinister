class SearchController < ApplicationController

  SEARCH_TYPES = {
    :mp => "mp",
    :party => "party",
    :constituency => "constituency",
    :state => "state"
  }

  def index
    results = params[:type].camelize.constantize.all(:conditions => ["upper(name) LIKE ?", "%#{params[:name].upcase}%"], :limit => 20)
    respond_to do |format|
      format.json {render :json => results.to_json}
      format.xml {render :xml => results.to_xml}
    end
  end

end