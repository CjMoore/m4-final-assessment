class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if current_user.nil?
      redirect_to signup_path
    else
      @link = Link.new
    end
  end

  def create
    user = current_user
    @link = user.links.new(link_params)
    if @link.save
      render partial: 'shared/new_link', layout: false
    else
      # byebug
      flash[:error] = @link.errors.full_messages.to_sentence
      render partial: 'shared/flash_error', layout: false
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
