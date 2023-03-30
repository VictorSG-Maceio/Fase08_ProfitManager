class Api::V1::ExpensesController < Api::V1::BaseController

    before_action :authenticate_with_token!

    def index
        render json: { expenses: @current_user.expenses }, status: 200
    end

    def show
        expense = @current_user.expenses.find(params[:id])
        if expense != nil
            render json: expense, status: 200
        else
            render json: {}, status: 404
        end
    end

    def create
        expense = @current_user.expenses.build(expenses_params)
        if expense.save!
            render json: expense, status: 201
        else
            render json: expense.errors, status: 422
        end
    end

    def update
        expense = @current_user.expenses.find(params[:id])
        if expense != nil
            if expense.update(expenses_params)
                render json: expense, status: 201
            else
                render json: expense.errors, status: 422
            end
        else
            render json: {}, status: 404
        end
    end

    def destroy
        expense = @current_user.expenses.find(params[:id])
        if expense != nil
            expense.destroy!
            render json: {}, status: 204
        else
            render json: {}, status: 404
        end
    end

    private
        def expenses_params
            params.require(:expense).permit(:description, :value, :date)
        end
    
end
