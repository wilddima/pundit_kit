class AdminController < ApplicationController
  def index
    authorize_all :post
    render plain: :ok
  end

  def pundit_context
    :admin
  end
end
