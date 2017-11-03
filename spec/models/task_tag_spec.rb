require 'rails_helper'

RSpec.describe TaskTag, type: :model do
  
  # let(:task) { FactoryGirl.create(:task) }
  # let(:tag) { FactoryGirl.create(:tag) }
  # 
  # it "successfully creates new Task" do
  #   task_tag = TaskTag.new(task_id: task.id, tag_id: tag.id)
  #   binding.pry
  #   expect(task_tag.save).to eq(true)
  # end
  # 
  # it "returns errors when missing details" do
  #   task_tag = TaskTag.new
  #   
  #   expect(task_tag.save).to eq(false)
  #   expect(task_tag.errors.full_messages).to include("Task can't be blank")
  #   expect(task_tag.errors.full_messages).to include("Tag can't be blank")
  #   expect(task_tag.errors.full_messages).to include("Tasks must exist")
  #   expect(task_tag.errors.full_messages).to include("Tags must exist")
  # end
  
end
