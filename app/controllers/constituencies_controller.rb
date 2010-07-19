class ConstituenciesController < ApplicationController

  def index
    constituencies = Constituency.all(select_filters)
    respond_to do |format|
      format.json{ render :json => constituencies.to_json}
      format.xml{ render :xml => constituencies.to_xml}
    end 
  end

  def select_filters
    params[:state_id].blank? ? {} : {:state_id => params[:state_id]}
  end
end