class ApplicationController <  ActionController::Base
  include Pundit

  def current_user
    @current_user
  end
end
