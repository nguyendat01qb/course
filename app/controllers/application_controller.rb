class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_category
  before_action :list_news
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.is_admin
  end

  def set_category
    @home_categories = Category.all.to_a
  end

  def list_news
    count_courses = []
    list_course_new = Course.order("created_at desc").limit(4).to_a
    # Category.all.to_a.each do |category|
    #   next if category.child_categories.present?
    #   @count_courses << {:key => category.title, :value => category.courses.count }
    # end
    # @count_courses.sort_by{ |e| e[:value]}.reverse
    @list_news = {
      list_course_new: list_course_new
    }
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[first_name last_name phone email password password_confirmation is_admin is_author profile_photo remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_api_token(current_user)
    if user_signed_in?
      payload = current_user.generate_token
      cookies.permanent[:api_token] = payload
    end
  end

  def after_sign_in_path_for(resource)
    set_api_token(current_user)
    if current_user.is_admin?
      stored_location_for(resource) || root_url
    else
      previous_path = session[:previous_url]
      session[:previous_url] = nil
      previous_path || root_path
    end
  end
end
