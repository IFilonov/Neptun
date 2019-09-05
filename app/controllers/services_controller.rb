class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy, :start, :stop, :restart]

  def index
    @services = Service.includes(:group).ordered(current_user.ldap_login, current_user.ldap_password)
    @scenarios = Scenario.all
  end

  def show
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
    end
  end

  def start
    @answer = @service.do_start
  end

  def stop
    @answer = @service.do_stop
  end

  def restart
    @answer = @service.do_restart
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:id, :name, :path, :sudo_name, :group_id, :user_id, :state, :start, :stop, :restart, :server_id, :status)
    end
end
