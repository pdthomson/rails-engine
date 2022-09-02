class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def self.name_search(item_name)
    where("name ILIKE ?", "%#{item_name}").order(:name)
  end

  def self.min_price_search(item_price)
    where("unit_price > ?", "#{item_price}").order(:name)
  end

  def self.max_price_search(item_price)
    where("unit_price < ?", "#{item_price}").order(:name)
  end
end
