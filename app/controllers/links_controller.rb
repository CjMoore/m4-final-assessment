class LinksController < ApplicationController

  def index
    if current_user.nil?
      redirect_to signup_path
    else
      @link = Link.new
    end
  end

  def create
    byebug
  end
end
