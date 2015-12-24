class ServersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @servers = Server.all
  end
  
  def show
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html # va a show
      format.json { render json: @server }
    end
  end
  
  def new
    @server = Server.new
  end
  
  def edit
    @server = Server.find(params[:id])
  end
  
  def create
    @server = Server.new(server_params)
    if @server.save
      respond_to do |format|
        format.html { redirect_to @server, notice: 'Registro correctamente creado.' }
        format.json { render json: @server }
      end
    else
      render 'new'
    end
  end
  
  def update
    @server = Server.find(params[:id])
    if @server.update(server_params)
      redirect_to @server
    else
      render 'edit'
    end
  end
  
  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    redirect_to servers_path
  end
  
  private
  def server_params
    params.require(:server).permit(:name,:ip,:dns)
  end
end
