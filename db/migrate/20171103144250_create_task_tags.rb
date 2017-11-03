class CreateTaskTags < ActiveRecord::Migration[5.1]
  def change
    create_table :task_tags do |t|
      t.integer :task_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
    
    add_index :task_tags, :task_id
    add_index :task_tags, :tag_id
  end
end
