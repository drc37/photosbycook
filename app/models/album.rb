class Album < ActiveRecord::Base
  has_many :images
  belongs_to :category
  belongs_to :subcategory
end
