class HomeController < ApplicationController
  layout 'default', only: :error
  before_action :authenticate, only: :error
  def index
    if signin?
      redirect_to_home_page(@current_user)
    else
      redirect_to signin_path
    end
  end

  def welcome
    render 'welcome', layout: false
  end

  def file_not_found
    render 'home/file_not_found', layout: 'error'
  end

  def unprocessable
    render 'home/unprocessable', layout: 'error'
  end

  def internal_server_error
    render 'home/internal_server_error', layout: 'error'
  end

end
