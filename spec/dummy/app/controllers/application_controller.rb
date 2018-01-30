class ApplicationController <  ActionController::Base
  include Pundit

  def current_user
    :user
  end
end
