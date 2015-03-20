class UsersController < ApplicationController
  before_action :verify_colleague, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    @user = User.find(params[:id])
    @feedbacks = @user.feedbacks.paginate(page: params[:page])
    @feedback = @user.feedbacks.build if verified_colleague?
    @feed_items = @user.feed.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash["success"] = "New colleague created!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :answer1, :answer2, :picture)
  end
  
  
  #before filters
  
 

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
