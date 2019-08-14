class ScenariosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scenario, only: [:edit, :update, :destroy]

  def index
    @scenarios = Scenario.all
    @scenario = Scenario.new
  end

  def new

  end

  def edit
  end

  def create
    @scenario = Scenario.new(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to scenarios_path, notice: 'Secnario was successfully created.' }
      else
        format.html { redirect_to scenarios_path, notice: 'Scenario was not successfully created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @scenario.update(server_params)
        format.html { redirect_to @scenario, notice: 'Server was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
    end
  end

  private
    def set_scenario
      @scenario = Server.find(params[:id])
    end

    def scenario_params
      params.require(:scenario).permit(:name)
    end
end
