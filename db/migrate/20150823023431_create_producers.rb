class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|
      t.text :name
      t.text :class_year
      t.text :bio
      t.integer :albums_count

      t.timestamps null: false
    end
  end
end
