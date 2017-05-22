class LinksController < ApplicationController

  def index
    if current_user.nil?
      redirect_to signup_path
    else
    end
  end
end
