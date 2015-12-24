class InfosController < ApplicationController
  #skip_before_filter :verify_authenticity_token, :if => Info.new { |c| c.request.format == 'application/json' }
  skip_before_action :verify_authenticity_token
  def index
    @infos = Info.all.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end
  
  def create
    @info = Info.new(info_params)    
    if @info.save
      respond_to do |format|
        format.html { redirect_to @info, notice: 'Registro correctamente creado.' }
        format.json { render json: @info }
      end
    end
  end

  def show
    #render action: "chart"
  end
  
  private
  def info_params
    params.require(:info).permit(:server_id,:cpucharge,:diskspace,:created_at,:updated_at)
  end
  
#  def chart
#    @info = Info.last
#    redirect_to "chart"
#  end
end
