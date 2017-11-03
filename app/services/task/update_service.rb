class Task::UpdateService < Task::Base
    
  include Virtus.model
  attribute :status_code, Symbol
    
  def update
    validate!
    
    if valid?
      task.save 
      add_tags
    end
    
    valid?
  end
  
  private
  
    def init_task
      task = Task.find_by(id: id)
      task.attributes = task_params if task.present?
      task
    end
  
    def validate!      
      unless task.present?
        errors << "Task with id '#{id}' not found"
        set_status_code(:not_found)
      else        
        task.valid?
        errors.concat(task.errors.full_messages)
        set_status_code(:not_acceptable)
      end
    end
    
    def set_status_code(status_code)
      self.status_code = valid? ? :ok : status_code
    end
    
end