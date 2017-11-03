class Task::UpdateService < Task::Base
    
  include Virtus.model
  attribute :status_code, Symbol
    
  def update
    if errors.blank?
      task.save 
      add_tags
    end
    
    errors.blank?
  end
  
  private
  
    def init_task
      task = Task.find_by(id: id)
      task.attributes = task_params if task.present?
      task
    end
  
    def validate!      
      unless task.present?
        self.status_code = :not_found
        ["Task with id '#{id}' not found"]
      else        
        task.valid?
        self.status_code = :not_acceptable
        task.errors.full_messages
      end      
    end
    
end