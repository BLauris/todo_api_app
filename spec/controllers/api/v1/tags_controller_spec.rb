require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :controller do

  describe 'GET /api/v1/tags' do
    
    it 'returns all tags' do
      get :index
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(response_json["data"].size).to eq(18)
    end
  end
  
  describe 'POST /api/v1/tags' do
    it "successfully creates new Tag" do
      expect{
        post :create, params: { attributes: { title: "Tag 1" } }
      }.to change{ Tag.count }.by(1)
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(response_json["data"]["attributes"]["title"]).to eq("Tag 1")
    end
    
    it "responds with errors" do
      expect{
        post :create, params: { attributes: { title: "" } }
      }.to_not change(Tag, :count)
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(406)
      expect(response_json["errors"]).to include("Title can't be blank")
    end
  end
  
  describe 'PUT /api/v1/tags/:id' do
    let(:tag) { FactoryGirl.create(:tag) }
    
    it "successfully updates Tag" do
      put :update, params: { id: tag.id,  attributes: { title: "Wosh" } }
      
      tag.reload
      
      expect(response).to have_http_status(200)
      expect(tag.title).to eq("Wosh")
    end
    
    it "responds with missing data errors" do
      put :update, params: { id: tag.id,  attributes: { title: "" } }
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(406)
      expect(response_json["errors"]).to include("Title can't be blank")
    end
    
    it "responds errors that Tag was not found" do
      put :update, params: { id: 0,  attributes: { title: "Wosh" } }
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(404)
      expect(response_json["error"]).to eq("Tag with id '0' not found")
    end
  end
  
  describe 'DELETE /tags/:id' do
    let(:tag) { FactoryGirl.create(:tag) }
    
    it "successfully desletes tag" do
      delete :destroy, params: { id: tag.id }
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(200)
      expect(response_json["message"]).to eq("Tag successfully destroyed")
    end
    
    it "returns error that Tag not found" do
      expect{
        delete :destroy, params: { id: "invalid_id" }
      }.to_not change(Tag, :count)
      
      response_json = JSON.parse(response.body)
      
      expect(response).to have_http_status(404)
      expect(response_json["error"]).to eq("Tag with id 'invalid_id' not found")
    end
    
  end
  
end
