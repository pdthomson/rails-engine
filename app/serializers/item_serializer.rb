class ItemSerializer
  class << self
    def create_items(items)
      {
        data: items.map do |item|
          {
            id: "#{item.id}",
            type: 'item',
            attributes:{
              name: item.name,
              description: item.description,
              unit_price: item.unit_price,
              merchant_id: item.merchant_id
            }
          }
        end
      }
    end
  end

  def create_item(item)
    {
      data: {
        id: "#{item.id}",
        type: 'item',
        attributes:{
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    }
  end
end
