class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    before_action :authenticate_user!, :update_allowed_parameters, if: :devise_controller?
  
    protected
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:name, :email, :password, :password_confirmation)
      end
    end
    protected

    # def after_sign_up_path_for(resource)
    #   new_user_session_path
    
    # end
    
    # def after_sign_in_path_for(resource)
    #   user_categories_path(current_user)
    # end

    # def after_sign_out_path_for(resource)
    #   root_path
    # end
    
end
