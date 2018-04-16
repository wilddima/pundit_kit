class ApplicationController <  ActionController::Base
  include Pundit
  include PunditKit

  rescue_from Pundit::NotAuthorizedError do
    render plain: :forbidden, status: :forbidden
  end

  def current_user
    @current_user
  end

  def pundit_namespace_matcher
    pundit_user
  end

  def pundit_context
    :users
  end
end
