ActiveAdmin.setup do |config|
  config.site_title = "Blog"
  config.authentication_method = :authenticate_admin!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
end
