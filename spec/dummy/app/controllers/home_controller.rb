class HomeController < ApplicationController
  def index
    authorize_all :post
  end
end
