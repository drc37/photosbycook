class AddSmugmugTables < ActiveRecord::Migration
  def self.up
    create_table :albums, :force => true do |t|
      t.integer :s_album_id, :subcategory_id, :category_id, :subcategory_id
      t.string :title, :description, :subcategory
      t.timestamps
    end
    
    create_table :categories, :force => true do |t|
      t.integer :s_category_id
      t.string :title
      t.timestamps
    end
    
    create_table :subcategories, :force => true do |t|
      t.integer :s_subcategory_id
      t.string  :title
      t.timestamps
    end

    rename_column :images, :description, :caption
    add_column :images, :file_name, :string
    add_column :images, :album_id, :integer
    add_column :images, :s_image_id, :integer
    add_column :images, :keywords, :string
    add_column :images, :size, :integer
    add_column :images, :TinyURL, :string
    add_column :images, :ThumbURL, :string
    add_column :images, :SmallURL, :string
    add_column :images, :MediumURL, :string
    add_column :images, :LargeURL, :string
    add_column :images, :XLargeURL, :string
    add_column :images, :X2LargeURL, :string
    add_column :images, :X3LargeURL, :string
    add_column :images, :OriginalURL, :string
    add_column :images, :Video320URL, :string
    add_column :images, :Video640URL, :string
    add_column :images, :Video960URL, :string
    add_column :images, :Video12800URL, :string
    
    remove_column :images, :name
    remove_column :images, :url
    remove_column :images, :category_id
    
  end

  def self.down
    remove_column :images, :file_name
    add_column :images, :category_id, :integer
    rename_column :images, :title, :name
    change_column :images, :name, :string
    remove_column :images, :album_id, :string
    add_column :images, :s_image_id
    drop_table :images
    drop_table :subcategories
    drop_table :categories
    drop_table :albums
  end
end