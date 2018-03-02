class ClientNotAllowedError < StandardError; end
class UserNotAllowedError < StandardError; end

PunditNamespaces.routes do
  namespace :staff, if: -> (user) { user.staff? } do
    namespace :admin, if: -> (user) { user.admin? }
    namespace :user, if: -> (user) { user.user? }, error: UserNotAllowedError
  end

  namespace :client, if: -> (user) { user.client? }, error: ClientNotAllowedError
end
