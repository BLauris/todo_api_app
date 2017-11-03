module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: [:update, :destroy]
      
      def index
        render json: Tag.all, each_serializer: TaskSerializer, status: :ok
      end
      
      def create
        tag = Tag.new(tag_params)
        
        if tag.save
          render json: tag, each_serializer: TagSerializer, status: :ok
        else
          render json: { errors: tag.errors.full_messages }, status: :not_acceptable
        end
      end
      
      def update
        if @tag.update(tag_params)
          render json: @tag, each_serializer: TagSerializer, status: :ok
        else
          render json: { errors: @tag.errors.full_messages }, status: :not_acceptable
        end
      end
      
      def destroy        
        if @tag.destroy
          render json: {message: "Tag successfully destroyed"}, status: :ok
        else
          render json: {error: "Tag with id '#{params[:id]}' not found"}, status: :not_found
        end
      end
      
      private
      
        def tag_params
          params.require(:attributes).permit(:title)
        end
        
        def set_tag
          @tag = Tag.find_by(id: params[:id])
          
          unless @tag.present?
            render json: {error: "Tag with id '#{params[:id]}' not found"}, status: :not_found
          end
        end
      
    end
  end
end