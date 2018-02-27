module CurrentUserHelper
  def sign_in(user)
    @controller.instance_variable_set(:@current_user, user)
  end

  def sign_out(user)
    @controller.instance_variable_set(:@current_user, nil)
  end
end
