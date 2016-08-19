class Category < ApplicationRecord
  has_many :products
  has_many :subcategories, class_name: "Category",
           foreign_key: "parent_category_id"

  belongs_to :parent_category, class_name: "Category"
  validates :name, presence: true
end
