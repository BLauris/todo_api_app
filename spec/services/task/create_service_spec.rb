require 'rails_helper'

describe Task::CreateService do
  
  context "Happy Path" do
    it "successfully creates new Task" do
      service = Task::CreateService.new(task_params: { title: "Task 1" }, tag_list: [])
      
      expect(service.errors).to eq([])
      expect(service.save).to eq(true)
      expect(service.task.title).to eq("Task 1")
      expect(service.task.tags.count).to eq(0)
    end
    
    it "successfully creates new Task and adds tasks" do
      service = Task::CreateService.new(task_params: { title: "Task 2" }, tag_list: ["tag1", "tag2", ""])
      
      expect(service.errors).to eq([])
      expect(service.save).to eq(true)
      expect(service.task.title).to eq("Task 2")
      expect(service.task.tags.count).to eq(2)
      expect(Tag.where(title: "tag1").exists?).to eq(true)  
      expect(Tag.where(title: "tag2").exists?).to eq(true)  
    end
  end
  
  context "Sad Path" do
    it "returns errors on invalid 'task_params'" do
      service = Task::CreateService.new(task_params: { title: "" }, tag_params: [])
      
      expect(service.save).to eq(false)
      expect(service.errors).to include("Title can't be blank")
    end
  end
  
end