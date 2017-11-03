require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

  describe 'GET /api/v1/tasks' do
    
    before { get :index }
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all tasks items' do
      json = JSON.parse(response.body)
      expect(json["data"]).to eq(0)
    end
  end
  
  describe 'POST /api/v1/tasks' do
    context "Happy Path" do      
      let(:valid_params) { { attributes: { title: "Do Homework", tags: [] } } }
      
      it "successfully creates new task" do
        expect{
          post :create, params: valid_params
        }.to change{Task.count}.by(1)
         .and change{ Tag.count }.by(0)
         .and change{ TaskTag.count }.by(0)
        
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(200)
        expect(response_json["title"]).to eq(valid_params[:attributes][:title])
      end
      
      it "successfully creates new task and adds tags" do
        valid_params[:attributes][:tags] = ["tag_1", "", "tag_2", "tag_2"]
        
        expect{
          post :create, params: valid_params
        }.to change{ Task.count }.by(1)
         .and change{ Tag.count }.by(2)
         .and change{ TaskTag.count }.by(2)
        
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(200)
        expect(response_json["title"]).to eq(valid_params[:attributes][:title])
      end
    end
    
    context "Sad Path" do 
      let(:invalid_params) { { attributes: { title: "" } } }
      
      it "returns errors for invalid data" do
        expect{
          post :create, params: invalid_params
        }.to_not change(Task, :count)
        
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(406)
        expect(response_json["errors"]).to include("Title can't be blank")
      end
    end
  end
  
  describe 'PUT /api/v1/tasks/:id' do
    let(:task) { FactoryGirl.create(:task) }
    let(:tag) { FactoryGirl.create(:tag) }
    
    context "Happy Path" do
      let(:valid_params) { { id: task.id, attributes: { title: "new title", tags: [] } } }
      
      it "successfully updates task" do
        put :update, params: valid_params
        
        task.reload
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(200)
        expect(task.title).to eq("new title")
        expect(response_json["id"]).to eq(task.id)
        expect(response_json["title"]).to eq(task.title)
      end
      
      it "successfully updates task and adds tags" do
        valid_params[:attributes][:tags] = [tag.title, "", "tag_2"]
        
        expect{
          put :update, params: valid_params
        }.to change{ Task.count }.by(0)
         .and change{ Tag.count }.by(1)
         .and change{ TaskTag.count }.by(2)
         
         task.reload
         response_json = JSON.parse(response.body)
         
         expect(response).to have_http_status(200)
         expect(task.title).to eq("new title")
      end
      
    end
    
    context "Sad Path" do
      let(:invalid_params) { { id: task.id, attributes: { title: nil } } }
      
      it "returns error on title" do
        put :update, params: invalid_params
        
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(406)
        expect(response_json["errors"]).to include("Title can't be blank")
      end
      
      it "returns error: task not found" do
        put :update, params: { id: "invalid id", attributes: { title: "New title" } }
        
        response_json = JSON.parse(response.body)
        
        expect(response).to have_http_status(404)
        expect(response_json["errors"]).to include("Task with id 'invalid id' not found")
      end
    end
  end
  
  describe 'DELETE /tasks/:id' do
    let(:task) { FactoryGirl.create(:task) }
    
    it "successfully desletes task" do
      delete :destroy, params: { id: task.id }
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(response_json["message"]).to eq("Task successfully destroyed")
    end
    
    it "returns error that Task not found" do
      expect{
        delete :destroy, params: { id: "invalid_id" }
      }.to_not change(Task, :count)
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(404)
      expect(response_json["error"]).to eq("Task with id 'invalid_id' not found")
    end
  end
end
