class Task::CreateService < Task::Base
  
  def save
    validate!
    
    if valid?
      task.save 
      add_tags
    end
    
    valid?
  end
  
  private
  
    def init_task
      Task.new(task_params)
    end
    
    def validate!
      task.valid?
      errors.concat(task.errors.full_messages)
    end
  
end