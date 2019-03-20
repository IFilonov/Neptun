class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end
end
