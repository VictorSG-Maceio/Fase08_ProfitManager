class Api::V2::ExpensesController < Api::V2::BaseController

  before_action :authenticate_api_v2_user!
  
    def index
      expenses = current_user.expenses
      render json: { expenses: expenses }, status: 200
    end
  
    def show
      begin
        expense = current_user.expenses.find(params[:id])
        render json: expense, status: 200
      rescue
        render json: {}, status: 404
      end
    end
  
    def create
      expense = current_user.expenses.build(expense_params)
      if expense.save
        render json: expense, status: 201
      else
        render json: { errors: expense.errors }, status: 422
      end
    end
  
    def update
      expense = current_user.expenses.find(params[:id])
      if expense.update_attributes(expense_params)
        render json: expense, status: 200
      else
        render json: { errors: expense.errors }, status: 422
      end
    end
  
    def destroy
      expense = current_user.expenses.find(params[:id])
      expense.destroy
      render json: {}, status: 204
    end
  
    private
      def expense_params
          params.require(:expense).permit(:description, :value, :date)
      end
  end