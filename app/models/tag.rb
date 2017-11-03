class Tag < ApplicationRecord
  
  validates :title, presence: true
  validates_uniqueness_of :title
  
  has_many :task_tags
  has_many :tasks, through: :task_tags
  
  default_scope { order(created_at: :desc) }
  
end
