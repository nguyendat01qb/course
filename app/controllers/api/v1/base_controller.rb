class Api::V1::BaseController < ApplicationController
  before_action :verify_token
  skip_before_action :verify_authenticity_token

  protected

  def success_message(message, content = {}, code = 200)
    ResponseTemplate.success(message, content, code)
  end

  def error_message(message, content = {}, code = 500)
    ResponseTemplate.error(message, content, code)
  end

  def unauthorized_message(message, content = {}, code = 401)
    ResponseTemplate.unauthorized(message, content, code)
  end

  def api_token?
    request.headers['Api-token'].present?
  end

  def current_user
    @current_user ||= User.find_by(api_token_digest: request.headers['Api-token'])
  end

  def verify_token
    return if api_token? && current_user

    render json: unauthorized_message('Unauthorized not valid')
  end

  def gravatar_for_user(user, size = 40)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def serializers(data, serializer, scope: nil)
    ActiveModelSerializers::SerializableResource.new(data,
                                                     each_serializer: serializer, scope: scope)
  end
end
