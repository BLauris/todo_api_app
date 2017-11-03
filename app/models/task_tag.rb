class TaskTag < ApplicationRecord
  
  # validates :task_id, :tag_id, presence: true 
  
  belongs_to :task
  belongs_to :tag
  
end
