class Subcategory < ActiveRecord::Base
  has_many :subcategories
  has_many :albums
end
