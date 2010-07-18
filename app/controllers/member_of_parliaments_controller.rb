class MemberOfParliamentsController < ApplicationController

  def index
    mps = MemberOfParliament.all
    respond_to do |format|
      format.xml {render :xml => mps.to_xml}
      format.json {render :json => mps.to_json}
    end
  end

  def show
    mp = MemberOfParliament.get(params[:id])
    respond_to do |format|
      format.xml {render :xml => mp.to_xml}
      format.json {render :json => mp.to_json}
    end
  end

end