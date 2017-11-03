require 'rails_helper'

describe Task::UpdateService do
  let(:task) { FactoryGirl.create(:task, title: "Task 1") }
  let(:tag) { FactoryGirl.create(:tag) }
  
  context "Happy Path" do
    let(:valid_params) { { title: "Update 1" } }
    
    it "successfully creates new Task" do
      expect(task.title).to eq("Task 1")
      
      service = Task::UpdateService.new(id: task.id, task_params: valid_params, tag_list: [])
      
      expect(service.errors).to eq([])
      expect(service.update).to eq(true)
      expect(service.task.tags.count).to eq(0)
      
      task.reload
      expect(task.title).to eq(valid_params[:title])
    end
    
    it "successfully creates new Task and adds tasks" do
      TaskTag.create(task_id: task.id, tag_id: tag.id) 
      service = Task::UpdateService.new(id: task.id, task_params: valid_params, tag_list: ["tag2", ""])
      expect(service.task.tags.count).to eq(1)
      
      expect(service.errors).to eq([])
      expect(service.update).to eq(true)
      expect(service.task.tags.count).to eq(2)
      expect(Tag.where(title: "tag2").exists?).to eq(true)  
      
      task.reload
      expect(task.title).to eq(valid_params[:title])
    end
  end
  
  context "Sad Path" do
    it "returns errors on invalid 'task_params'" do
      service = Task::UpdateService.new(id: task.id, task_params: { title: "" })
      
      expect(service.update).to eq(false)
      expect(service.errors).to include("Title can't be blank")
      expect(service.status_code).to eq(:not_acceptable)
    end
    
    it "returns errors when Task not found" do
      service = Task::UpdateService.new(id: 0, task_params: { title: "" })
      
      expect(service.update).to eq(false)
      expect(service.errors).to include("Task with id '0' not found")
      expect(service.status_code).to eq(:not_found)
    end
  end
  
end