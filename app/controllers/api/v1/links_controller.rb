class Api::V1::LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def index
    @links = current_user.links
    render json: @links
  end

  def recent_links
    @links = Link.get_recent_read
    render json: @links
  end

  private

  def link_params
    params.permit(:read)
  end
end
