class Api::V1::ExpensesController < Api::V1::ApiController

  before_action :authenticate

  def index  

    if authenticate    
        #byebug
        start_date = params[:start_date].respond_to?(:to_date) ? params[:start_date].to_date : @user.expenses.min_by(&:date).date
        end_date = params[:end_date].respond_to?(:to_date) ? params[:end_date].to_date : @user.expenses.max_by(&:date).date
        @expenses = @user.expenses_between_dates(start_date, end_date) 

    else

      render json: { message: "Invalid token"}, status: 401


    end  

  end

  def create
    #date = params[:date]
    #amount = 
    if params[:date] && params[:amount]
      Expense.create(date: params[:date], amount: params[:amount], user_id: @user.id)
      render json: { message: "Good going! You made an expense for #{params[:amount]}"}, status: 200
    else
      whats_not_supplied(params)     
    end
    #byebug

    
  end

  private

  def whats_not_supplied(params)
    if !params[:date]
        render json: { message: "You didn't supply a date. Expense not created"}
      else
        render json: { message: "You didn't supply an amount. Expense not created"}
      end
  end
  # def auth
  #   return authenticate
  # end



end
