class MerchantSerializer

  class << self
    def create_merchants(merchants)
     {
        data: merchants.map do |merchant|
          {
            id: "#{merchant.id}",
            type: 'merchant',
            attributes:{
              name: merchant.name
            }
          }
        end
      }
    end

    def create_merchant(merchant)
      {
        data: {
          id: "#{merchant.id}",
          type: 'merchant',
          attributes: {
            name: merchant.name
          }
        }
      }
    end

    def no_merchant
      {
        data: {}
      }
    end
  end
end
