ActiveAdmin.register User do
  actions :all, :except => [:show]
  config.sort_order = "name_asc"
  permit_params :id, :name, :email, :password, :password_confirmation, :admin

  ####################
  # Index Page       #
  ####################
  index do
    selectable_column
    column :name
    column :email
    column :role do |user|
      status_tag(:admin, :orange) if user.admin?
    end
    column :current_sign_in_at
    # column :locked do |user|
    #   status_tag(:locked, :red) if user.max_login_attempts?
    # end
    actions defaults: true do |user|
      # item link_to("Unlock", action_resource_path(user, :unlock), class: "member_link") if user.max_login_attempts?
    end
  end

  ####################
  # Filters.         #
  ####################
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  ####################
  # Form.            #
  ####################
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.actions
  end

  ####################
  # Actions.         #
  ####################
  member_action :unlock, method: :get do
    resource.update_attribute :second_factor_attempts_count, 0
    redirect_to collection_path, notice: "User has been unlocked"
  end
end
