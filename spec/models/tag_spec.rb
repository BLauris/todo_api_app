require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag_1) { FactoryGirl.create(:tag) }
  
  it "successfully creates new Tag" do
    tag = Tag.new(title: "New test tag")
    
    expect(tag.save).to eq(true)
  end
  
  it "returns errors when missing title" do
    tag = Tag.new
    
    expect(tag.save).to eq(false)
    expect(tag.errors.full_messages).to include("Title can't be blank")
  end
  
  it "returns errors when duplicate Tag" do
    tag = Tag.new(title: tag_1.title)
    
    expect(tag.save).to eq(false)
    expect(tag.errors.full_messages).to include("Title has already been taken")
  end
  
end
