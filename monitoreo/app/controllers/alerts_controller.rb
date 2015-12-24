class AlertsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @alerts = Alert.all
  end
  
  def show
    @alert = Alert.find(params[:id])
  end
  
  def new
    @alert = Alert.new
    @users = User.all
    @rules = Rule.all
  end
  
  def edit
    @alert = Alert.find(params[:id])
    @users = User.all
    @rules = Rule.all
  end
  
  def create    
    @alert = Alert.new(alert_params)
    @users = User.all
    @rules = Rule.all
    if @alert.save
      redirect_to @alert
    else
      render 'new'
    end
  end
  
  def update
    @alert = Alert.find(params[:id])
    if @alert.update(alert_params)
      redirect_to @alert
    else
      render 'edit'
    end
  end
  
  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_to alerts_path
  end
  
  private
  def alert_params
    params.require(:alert).permit(:user_id,:rule_id)
  end
end
