class RulesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @rules = Rule.all.order('priority DESC')
  end
  
  def show
    @rule = Rule.find(params[:id])
    respond_to do |format|
      format.html # va a show
      format.json { render json: @rule }
    end
  end
  
  def new
    @rules = Rule.all.order('priority DESC')
    @rule = Rule.new
  end
  
  def edit
    @rules = Rule.all.order('priority DESC')
    @rule = Rule.find(params[:id])
  end
  
  def create
    @rules = Rule.all.order('priority DESC')
    @rule = Rule.new(rule_params)
    if @rule.save
      respond_to do |format|
        format.html { redirect_to @rule, notice: 'Registro correctamente creado.' }
        format.json { render json: @rule }
      end
    else
      render 'new'
    end
  end
  
  def update
    @rule = Rule.find(params[:id])
    if @rule.update(rule_params)
      redirect_to @rule
    else
      render 'edit'
    end
  end
  
  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    redirect_to rules_path
  end
  
  private
  def rule_params
    params.require(:rule).permit(:name,:priority,:cpuchargeexceed,:diskspaceexceed,:timeexceed)
  end
end
