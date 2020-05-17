ActiveAdmin.register Service do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :path, :start, :stop, :server_id, :status, :group_id, :restart, :sudo_name, :state, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :path, :start, :stop, :server_id, :status, :group_id, :restart, :sudo_name, :state, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    id_column
    column :name
    column :path
    column :start
    column :stop
    column :restart
    column :server_id do |object|
      Server.find(object.server_id).name
    end
    column :status
    column :group_id do |object|
      Group.find(object.group_id).name
    end
    column :sudo_name
    column :state
    column :user_id do |object|
      User.find(object.user_id).email
    end
    actions
  end

end
