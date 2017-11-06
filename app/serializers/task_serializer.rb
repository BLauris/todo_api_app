class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at
  
  has_many :tags
  
  def created_at
    object.created_at.strftime("%d/%m/%Y")
  end
  
  def updated_at
    object.updated_at.strftime("%d/%m/%Y")
  end
  
end
