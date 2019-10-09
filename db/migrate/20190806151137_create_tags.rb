class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :title, limit: 100, null: false

      t.timestamps
    end
  end
end
