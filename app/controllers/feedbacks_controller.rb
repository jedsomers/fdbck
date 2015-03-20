class FeedbacksController < ApplicationController
    before_action :verify_colleague, only: [:create, :edit, :update, :destroy]
    
    def create
        @user = User.find_by(params[:id])
        @feedback = @user.feedbacks.new(feedback_params)
        if @feedback.save
            flash[:success] = "Feedback left!"
            redirect_to @user
        else
            @feed_items = []
            render 'basic_pages/home'
        end
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    private
    
    def feedback_params
        params.require(:feedback).permit(:content)
    end
    
end
