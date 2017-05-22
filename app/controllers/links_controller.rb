class LinksController < ApplicationController

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
      
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      render :index
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
