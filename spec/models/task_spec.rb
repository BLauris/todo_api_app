require 'rails_helper'

RSpec.describe Task, type: :model do

  it "successfully creates new Task" do
    task = Task.new(title: "New test task")
    
    expect(task.save).to eq(true)
  end
  
  it "returns errors when missing details" do
    task = Task.new
    
    expect(task.save).to eq(false)
    expect(task.errors.full_messages).to include("Title can't be blank")
  end

end
