class Task::Base
  
  include Virtus.model(strict: true)
  attribute :id, String, default: ''
  attribute :task_params, Hash
  attribute :tag_list, Array
  attribute :task, Task, default: :init_task
  attribute :errors, Array, default: []
  
  private
  
    def add_tags
      Tag::AddToTasksService.add(tag_list, task.id)
    end
    
    def valid?
      errors.blank?
    end
    
end