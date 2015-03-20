class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:answer1])
      #log the user in and redirect to the user's show page
      log_in user
      remember user
      redirect_back_or(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid. No colleague by this name, or incorrect security answer'
      render 'new'
    end
  end

  def destroy
  end

end
