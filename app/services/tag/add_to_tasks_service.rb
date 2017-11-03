class Tag::AddToTasksService
  
  include Virtus.model(strict: true)
  attribute :tags, Array, default: []
  attribute :task_id, Integer
  
  def self.add(tags, task_id)
    service = self.new(tags: tags, task_id: task_id)
    service.create_and_add
  end
  
  def create_and_add
    tag_list.each do |title|
      tag = tag(title)
      create_task_tag(tag.id)
    end
  end
  
  private
  
    def create_task_tag(tag_id)
      TaskTag.find_or_create_by(tag_id: tag_id, task_id: task_id)
    end
    
    def tag(title)
      Tag.find_or_create_by(title: title)
    end
    
    def tag_list
      @tag_list ||= tags.reject(&:blank?).uniq
    end
end