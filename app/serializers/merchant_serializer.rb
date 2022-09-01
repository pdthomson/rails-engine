class MerchantSerializer

  class << self
    def create_merchants(merchants)
      wip = {
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

  end
end
