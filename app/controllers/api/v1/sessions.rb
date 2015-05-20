module API
  module V1
    class Sessions < Grape::API
      include API::V1::Defaults

      resources :sessions do
        get "" do
          Users.all
        end

        desc "Authenticate user and return user object, access token"
        params do
          group :user, type: Hash do
            requires :user_email, :type => String, :desc => "User email"
            requires :password, :type => String, :desc => "User password"
          end
        end
        post 'sign_in' do
           email = params[:user][:user_email]
           password = params[:user][:password]

           if email.nil? or password.nil?
             error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
             return
           end

           user = User.find_by(email: email.downcase)
           if user.nil?
              error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
              return
           end

           if !user.valid_password?(password)
              error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
              return
           else
             user.ensure_authentication_token
             user.save
              # status(201){
              #  status: 'ok',
              #  token: user.authentication_token
              # }
              # render json: { :user_token => user.authentication_token, :user_email => user.email, :token_type => "bearer" }, status: 201
              {
                :user_token => user.authentication_token, :user_email => user.email, :user_id => user.id, :token_type => "bearer"
              }
           end
        end

        desc "Register user and return user object, access token"
        params do
          requires :firstname, :type => String, :desc => "First Name"
          requires :lastname, :type => String, :desc => "Last Name"
          requires :email, :type => String, :desc => "Email"
          requires :password, :type => String, :desc => "Password"
        end
        post 'register' do
          user = User.new(
            firstname: params[:firstname],
            lastname:  params[:lastname],
            password:   params[:password],
            email:      params[:email]
          )

          if user.valid?
            user.save
            return user
          else
            error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
          end
        end

        desc "Logout user and return user object, access token"
        params do
          requires :token, :type => String, :desc => "Authenticaiton Token"
        end
        delete 'logout' do

          user = User.find_by(authentication_token: params[:token])

          if !user.nil?
            user.remove_authentication_token!
            status(200)
            {
              status: 'ok',
              token: user.authentication_token
            }
          else
            error!({:error_code => 404, :error_message => "Invalid token."}, 401)
          end
        end
      end
    end
  end
end
