class ScenariosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scenario, only: [:edit, :update, :destroy]

  def index
    @scenarios = Scenario.all
    @scenario = Scenario.new
    @services = Service.ordered
    @services.each do |s|
      @scenario.scenario_services.build({ :service_id => s.id })
    end
  end

  def new
    @scenario = Scenario.new
    @scenario.scenario_services.new
    @services = Service.all
  end

  def edit
  end

  def create
    @scenario = Scenario.new(scenario_params)
    respond_to do |format|
      if @scenario.save
        format.html { redirect_to scenarios_path, notice: 'Scenario was successfully created.' }
      else
        format.html { redirect_to scenarios_path, notice: 'Scenario was not successfully created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to scenarios_path, notice: 'Scenario was successfully updated.' }
      else
        format.html { redirect_to scenarios_path }
      end
    end
  end

  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.' }
    end
  end

  private
    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

    def scenario_params
      params.require(:scenario).permit(:name, scenario_services_attributes: [:service_id, :order, :id])
    end
end
