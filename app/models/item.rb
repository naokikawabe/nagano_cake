class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def taxin_price
    price*1.1
  end
end
