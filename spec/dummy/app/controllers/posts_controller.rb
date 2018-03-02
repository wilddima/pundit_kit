class PostsController < ApplicationController
  def index
    authorize_all :post
    render plain: 'Ok'
  end

  def show
    authorize_all :post
    render plain: 'Ok'
  end

  def create
    authorize_all :post
    render plain: 'Ok'
  end

  def update
    authorize_all :post
    render plain: 'Ok'
  end

  def destroy
    authorize_all :post
    render plain: 'Ok'
  end
end

