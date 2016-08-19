class Product < ApplicationRecord

  before_destroy :destroy_items

  has_many :photos, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  private
  def destroy_items
    items = ShoppingCartItem.where(item_id: id)
    items.destroy_all
  end
end
