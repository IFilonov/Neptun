# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[destroy edit update]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:id, :ldap_login, :ldap_password)
  end
end
