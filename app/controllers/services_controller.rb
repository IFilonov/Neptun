class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy, :start, :stop]

  def index
    @services = Service.all
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
    answer = send_command(@service.start)
    redirect_to services_path(:anchor => "wall"), notice: answer
  end

  def stop
    answer = send_command(@service.stop)
    redirect_to services_path(:anchor => "wall"), notice: answer
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :path, :group, :start, :stop, :server_id, :status)
    end

    def send_command(cmd)
      ssh = SshService.new(@service.server.host_name, current_user.ldap_login, current_user.ldap_password);
      ssh.send_command(@service.path) if @service.path.length > 0
      answer = ssh.send_command(cmd)
      ssh.close
      answer.byteslice(0, 2000)
    end
end
