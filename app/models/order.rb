class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum status: { pending: 0, paid: 1, shipped: 2, cancelled: 3 }

  before_save :calculate_total

  def calculate_total
    self.total = order_items.sum { |item| item.quantity * item.price }
  end
end
