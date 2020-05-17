ActiveAdmin.register Scenario do
  permit_params :name, :user_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :name
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }, selected: object.user_id
    end
    f.actions
  end

end
