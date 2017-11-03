class Task::CreateService < Task::Base
  
  def save
    if errors.blank?
      task.save 
      add_tags
    end
    
    errors.blank?
  end
  
  private
  
    def init_task
      Task.new(task_params)
    end
    
    def validate!
      task.valid?
      task.errors.full_messages
    end
  
end