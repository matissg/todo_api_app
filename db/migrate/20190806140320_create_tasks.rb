class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 500, null: false
      
      t.timestamps
    end
  end
end
