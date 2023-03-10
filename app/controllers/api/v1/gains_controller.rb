class Api::V1::GainsController < Api::V1::BaseController

    before_action :authenticate_with_token!
  
    def index
      gains = current_user.gains
      render json: { gains: gains }, status: 200
    end
  
    def show
      begin
        gain = current_user.gains.find(params[:id])
        render json: gain, status: 200
      rescue
        render json: {}, status: 404
      end
    end
  
    def create
      gain = current_user.gains.build(gain_params)
      if gain.save
        render json: gain, status: 201
      else
        render json: { errors: gain.errors }, status: 422
      end
    end
  
    def update
      gain = current_user.gains.find(params[:id])
      if gain.update_attributes(gain_params)
        render json: gain, status: 200
      else
        render json: { errors: gain.errors }, status: 422
      end
    end
  
    def destroy
      gain = current_user.gains.find(params[:id])
      gain.destroy
      render json: {}, status: 204
    end
  
    private
      def gain_params
          params.require(:gain).permit(:description, :value, :date)
      end
  end