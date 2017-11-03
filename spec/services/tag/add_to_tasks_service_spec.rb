require 'rails_helper'

describe Tag::AddToTasksService do
  
  let(:task) { FactoryGirl.create(:task) }
  let(:tags) { ["Tag 1", "Tag 2", nil, "Tag 4", "", "Tag 1"] }
  
  before do
    Tag::AddToTasksService.add(tags, task.id)
  end
  
  it "created tags with valid title" do
    expect(Tag.all.pluck(:title).sort).to eq(tags.reject(&:blank?).uniq.sort)
  end
  
end