if Rails.env == "test" || Rails.env == "development"
  puts " -----> START"

  Task.destroy_all
  Tag.destroy_all

  puts " -----> Add Tasks"
  10.times do
    Task.create(title: Faker::WorldOfWarcraft.quote)
  end

  puts " -----> Add Tasks with one Tag"
  3.times do
    task = Task.create(title: Faker::Witcher.quote)
    tag = Tag.create(title: Faker::Witcher.character)
    
    TaskTag.create(task_id: task.id, tag_id: tag.id)
  end

  puts " -----> Add Tasks with two Tag"
  3.times do
    task = Task.create(title: Faker::Witcher.quote)
    
    tag_1 = Tag.create(title: Faker::Witcher.character)
    tag_2 = Tag.create(title: Faker::Zelda.character)

    TaskTag.create(task_id: task.id, tag_id: tag_1.id)
    TaskTag.create(task_id: task.id, tag_id: tag_2.id)
  end

  puts " -----> Add Tasks with three Tag"
  3.times do
    task = Task.create(title: Faker::Food.dish)
    
    tag_1 = Tag.create(title: Faker::Food.spice)
    tag_2 = Tag.create(title: Faker::Space.galaxy)
    tag_3 = Tag.create(title: Faker::Vehicle.manufacture)

    TaskTag.create(task_id: task.id, tag_id: tag_1.id)
    TaskTag.create(task_id: task.id, tag_id: tag_2.id)
    TaskTag.create(task_id: task.id, tag_id: tag_3.id)
  end

  puts " -----> DONE"
end