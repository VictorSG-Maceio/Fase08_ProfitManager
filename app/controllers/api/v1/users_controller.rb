class Api::V1::UsersController < Api::V1::BaseController

    before_action :authenticate_with_token!, only: %i[ update destroy ]

    def index
        render json: {}, status: 200
    end

    def show
        user = User.find(params[:id])
        if user != nil
            render json: user, status: 200
        else
            render json: { errors: user.errors }, status: 404
        end
    end

    def create
        user = User.new(user_params)
        if user.save!
            render json: user, status: 201
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def update
        user = current_user
        if user.update(user_params)
            render json: user, status: 200
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def destroy
        current_user.destroy!
        render json: {}, status: 204
    end

    private
        def user_params
            params.require(:user).permit(:email, :password)
        end

end
