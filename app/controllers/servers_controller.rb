class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: [:edit, :update, :destroy, :show]

  def index
    @servers = Server.all
  end

  def new
    @server = Server.new
  end

  def edit
  end

  def show
  end

  def create
    @server = Server.new(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
    end
  end

  private
    def set_server
      @server = Server.find(params[:id])
    end

    def server_params
      params.require(:server).permit(:host_name, :ip)
    end
end
