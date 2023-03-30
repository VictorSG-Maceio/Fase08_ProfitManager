class Api::V2::GainsController < Api::V2::BaseController

    before_action :authenticate_api_v2_user!

    def index
        render json: { gains: current_api_v2_user.gains }, status: 200
    end

    def show
        gain = current_api_v2_user.gains.find(params[:id])
        if gain != nil
            render json: gain, status: 200
        else
            render json: {}, status: 404
        end
    end

    def create
        gain = current_api_v2_user.gains.build(gains_params)
        if gain.save!
            render json: gain, status: 201
        else
            render json: gain.errors, status: 422
        end
    end

    def update
        gain = current_api_v2_user.gains.find(params[:id])
        if gain != nil
            if gain.update(gains_params)
                render json: gain, status: 201
            else
                render json: gain.errors, status: 422
            end
        else
            render json: {}, status: 404
        end
    end

    def destroy
        gain = current_api_v2_user.gains.find(params[:id])
        if gain != nil
            gain.destroy!
            render json: {}, status: 204
        else
            render json: {}, status: 404
        end
    end

    private
        def gains_params
            params.require(:gain).permit(:description, :value, :date)
        end
end
