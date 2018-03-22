class ApplicationController <  ActionController::Base
  include Pundit
  include PunditKit

  def current_user
    @current_user
  end

  def pundit_namespace_matcher
    pundit_user
  end
end
