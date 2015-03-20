module SessionsHelper
    
    # logs in the given user
    def log_in(user)
        session[:user_id] = user.id
    end
    
    #remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.signed[:user_id] = { value: user.id, expires: 24.hours.from_now.utc }
        cookies[:remember_token] = { value: user.remember_token, expires: 24.hours.from_now.utc }
    end
    
    #returns the current logged-in user (if any)
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    #returns true if the user if logged in, false otherwise
    def verified_colleague?
        !current_user.nil?
    end
    
    #redirects to stored location (or to the default)
    def redirect_back_or(default)
        redirect_to(session[:forwawrding_url] || default)
        session.delete(:forwarding_url)
    end
    
    #stores the URL trying to be accessed
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
    
end

