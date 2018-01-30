class HomeController < ApplicationController
  def index
    authorize :post
  end
end
