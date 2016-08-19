class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :shopping_cart, dependent: :destroy

  validates :password, presence: true, confirmation: true
  validates :email, presence: true, uniqueness: true
end
