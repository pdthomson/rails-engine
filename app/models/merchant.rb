class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name

  def self.search(merchant_name)
    where("name ILIKE ?", "%#{merchant_name}%").order(:name)
  end
end
