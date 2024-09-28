class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user!


    def index
        user_data = User.where(merchant_id: 1)
        render json: { status: user_data.pluck(:name).compact, data: user_data }
    end
    
    def create 
        p "users",user_params
        user_data = User.create(user_params)
        if user_data.save
          render json: { status: 'success', data: user_data }
        else
          render json: { status: 'error', errors: user_data.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        user = Hash.new
        user["name"] = params["user"]["title"]
        user["last_name"] = params["user"]["lname"]
        user["email"] = params["user"]["email"]
        user["password"] = "123456"
        user["merchant_id"] = current_user.merchant_id
        user
    end

end
