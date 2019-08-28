class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy, :start, :stop]

  def index
    @services = Service.order(:group_id, :id)
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
    @answer = send_command(@service.start)
  end

  def stop
    @answer = send_command(@service.stop)
  end

  def stop
    @answer = send_command(@service.restart)
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :path, :sudo_name, :group_id, :start, :stop, :restart, :server_id, :status)
    end

    def send_command(cmd)
      ssh = SshService.new(@service.server.host_name, current_user.ldap_login, current_user.ldap_password);
      ssh.send_command(@service.path) if @service&.path.length > 0
      ssh.send_command("sudo -u #{@service.sudo_name} -i") if @service&.sudo_name.length > 0
      answer = ssh.send_command(cmd)
      ssh.close
      answer.byteslice(0, 2000).split(/\n/).join('\n')
    end
end
