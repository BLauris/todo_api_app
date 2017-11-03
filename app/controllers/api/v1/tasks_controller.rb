module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:destroy]
      
      def index
        render json: Task.all, each_serializer: TaskSerializer, status: :ok
      end
      
      def create
        service = Task::CreateService.new(task_params: task_params, tag_list: tag_params[:tags])
        
        if service.save
          render json: service.task, each_serializer: TaskSerializer, status: :ok
        else
          render json: { errors: service.errors }, status: :not_acceptable
        end
      end
      
      def update
        service = Task::UpdateService.new(id: params[:id], task_params: task_params, tag_list: tag_params[:tags])
        
        if service.update
          render json: service.task, each_serializer: TaskSerializer, status: :ok
        else
          render json: { errors: service.errors }, status: service.status_code
        end
      end
      
      def destroy        
        if @task.destroy
          render json: {message: "Task successfully destroyed"}, status: :ok
        else
          render json: {error: "Task with id '#{params[:id]}' not found"}, status: :not_found
        end
      end
      
      private
      
        def task_params
          params.require(:attributes).permit(:title)
        end
        
        def tag_params
          params.require(:attributes).permit(tags: [])
        end
        
        def set_task
          @task = Task.find_by(id: params[:id])
          
          unless @task.present?
            render json: {error: "Task with id '#{params[:id]}' not found"}, status: :not_found
          end
        end
      
    end
  end
end