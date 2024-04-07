class Api::V1::TodosController < ApplicationController
    before_action :authenticate_user!

    def index
        todos = current_user.to_dos
        render json: { status: 'success', data: todos }
    end

    def create
      todo = current_user.to_dos.build(todo_params)
  
      if todo.save
        render json: { status: 'success', data: todo }
      else
        render json: { status: 'error', errors: todo.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      todo = current_user.to_dos.find(params[:id])
  
      if todo.update(todo_params)
        render json: { status: 'success', data: todo }
      else
        render json: { status: 'error', errors: todo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def custom_update
        todo = current_user.to_dos.find(params[:id])
      
        if todo.update(todo_params)
          render json: { status: 'success', data: todo }
        else
          render json: { status: 'error', errors: todo.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    def destroy
      todo = current_user.to_dos.find(params[:id])
      todo.destroy
  
      render json: { status: 'success', message: 'Todo deleted successfully' }
    end
  
    private
  
    def todo_params
      params.require(:to_do).permit(:title, :description, :creator_id, :assign_user_id, :submission_date, :status)
    end
end


