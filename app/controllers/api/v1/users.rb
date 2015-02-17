module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do

        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "user" do
          User.where(id: permitted_params[:id]).first!
        end

        desc "Create an account"
        params do
          group :user, type: Hash do
            requires :email, :type => String, :desc => "User email"
            requires :password, :type => String, :desc => "User password"
            optional :firstname, type: String
            optional :lastname, type: String
          end
        end
        post '' do
          email = params[:user][:email]
          password = params[:user][:password]

           if email.nil? or password.nil?
             error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
             return
           end

           user = User.find_by(email: email.downcase)
           if !user.nil?
              error!({:error_code => 404, :error_message => "Existing user!"}, 401)
              return
           else
             #user.ensure_authentication_token
             #user.save
              # status(201){
              #  status: 'ok', 
              #  token: user.authentication_token 
              # }
              # render json: { :user_token => user.authentication_token, :user_email => user.email, :token_type => "bearer" }, status: 201
              # {
              #   :user_token => user.authentication_token, :user_email => user.email, :user_id => user.id, :token_type => "bearer"
              # }

              u = User.create!(
                :email => email,
                :password => password,
                :firstname => params[:user][:firstname],
                :lastname => params[:user][:lastname]
              )

              {user: {email: email, password: password, id: u.id}}
           end
        end
      end
    end
  end
end