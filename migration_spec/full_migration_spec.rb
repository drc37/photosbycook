# require File.dirname(__FILE__) + '/../spec/spec_helper'
require 'test/unit'
require 'migration_test_helper'

describe "Full Migration Test" do
  # self.use_transactional_fixtures = false

  it "should have the full schema" do
    # pending
    begin
      drop_all_tables
      see_empty_schema
      migrate
      see_full_schema
    ensure
      migrate
    end
  end  

  def see_empty_schema
    assert_schema do |s|
    end
  end

  def see_full_schema    
    assert_schema do |s|
      s.table :images do |t|
        t.column :id, :integer
        t.column :category_id, :integer
        t.column :name, :string
        t.column :description, :string
        t.column :url, :string
        t.column :width, :integer
        t.column :height, :integer
      end
    end
  end
end
