class MpsController < ApplicationController

  def index
    mps = Mp.all(select_filters)
    respond_to do |format|
      format.xml {render :xml => mps.to_xml(:only => [:id, :name])}
      format.json {render :json => mps.to_json(:only => [:id, :name])}
    end
  end

  def show
    mp = Mp.first(select_show_filter)
    
    respond_to do |format|
      format.xml {render :xml => mp.to_xml(:methods=> [:party, :constituency])}
      format.json {render :json => mp.to_json(:methods=> [:party, :constituency])}
    end
  end
  
  private 
  def select_filters
    filters = {}
    constituency_ids = State.get(params[:state_id]).constituencies.collect{|constituency|constituency.id} unless params[:state_id].blank?
    filters[:constituency_id] = constituency_ids unless constituency_ids.blank?
    filters[:party_id] = params[:party_id] unless params[:party_id].blank?
    filters
  end
  
  def select_show_filter
    return {:id => params[:id]} unless params[:id].blank?
    {:constituency_id => params[:constituency_id]} unless params[:constituency_id].blank?
  end
  
end