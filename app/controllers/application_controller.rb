class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = if current_user
                      "You are not authorized to access this page"
                    else
                      "Login to continue. You might not have access to this page"
                    end
      redirect_back(fallback_location: root_path)
  end
end
