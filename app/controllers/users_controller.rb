class UsersController < ApplicationController

  def signup
  end

  def new
    @user = User.new
  end
end
