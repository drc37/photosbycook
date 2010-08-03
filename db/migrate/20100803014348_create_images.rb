class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :category_id, :width, :height
      t.string :name, :description, :url
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
