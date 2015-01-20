class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user_from_token!
  before_filter :use_dummy_session

  private

    def authenticate_user_from_token!
      authenticate_with_http_token do |token, options|
        user_email = options[:user_email].presence
        user       = user_email && User.find_by_email(user_email)

        if user && Devise.secure_compare(user.authentication_token, token)
          sign_in user, store: false
        end
      end
    end

    def use_dummy_session
      return unless request.format.xml? || request.format.json?
      env["rack.session"] = {}
    end
end
