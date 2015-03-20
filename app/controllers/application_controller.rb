class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
  #confirms a verified colleague
  def verify_colleague
    unless verified_colleague?
    store_location
    flash[:danger] = "Please answer the security questions for this colleague correctly"
    redirect_to login_url
    end
  end
    
end
