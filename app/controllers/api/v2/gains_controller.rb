class Api::V2::GainsController < Api::V2::BaseController

    before_action :authenticate_user!
  
    def index
      q = current_user.gains.ransack(params[:q])
      gains = q.result(distinct: true)
      render json: gains, status: 200
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