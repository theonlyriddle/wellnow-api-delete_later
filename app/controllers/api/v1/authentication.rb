module API
  module V1
    module Authentication
      extend ActiveSupport::Concern

      included do
        before do
           error!("401 Unauthorized", 401) unless authenticated?
         end

         helpers do
           def warden
             env['warden']
           end

           def authenticated?
             return true if warden.authenticated?
             params[:access_token] && @user = User.find_by(authentication_token: params[:access_token])
           end

           def current_user
             warden.user || @user
           end
         end
       end
     end
   end
end