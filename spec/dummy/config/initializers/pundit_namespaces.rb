PunditNamespaces.routes do
  namespace :staff, if: -> (user) { user.staff? } do
    namespace :admin, if: -> (user) { user.admin? }
    namespace :user, if: -> (user) { user.user? }
  end

  namespace :client, if: -> (user) { user.client? }
end
