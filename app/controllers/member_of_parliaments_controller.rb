class MemberOfParliamentsController < ApplicationController

  def index
    mps = MemberOfParliament.all
    respond_to do |format|
      format.xml {render :xml => mps.to_xml(:only => [:id, :name])}
      format.json {render :json => mps.to_json(:only => [:id, :name])}
    end
  end

  def show
    mp = MemberOfParliament.get(params[:id])
    respond_to do |format|
      format.xml {render :xml => mp.to_xml(:methods=> [:party, :constituency])}
      format.json {render :json => mp.to_json(:methods=> [:party, :constituency])}
    end
  end

end