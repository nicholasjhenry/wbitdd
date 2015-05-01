require "price"

describe "in-memory catalog" do
  describe "find price" do
    specify "product found" do
      found_price = Price.cents(1250)
      catalog = InMemoryCatalog.new("12345" => found_price)

      expect(catalog.find_price("12345")).to eq(found_price)
    end

    specify "product not found" do
      catalog = InMemoryCatalog.new({})
      expect(catalog.find_price("12345")).to be_nil
    end
  end

  class InMemoryCatalog
    def initialize(prices_by_barcode)
      @prices_by_barcode = prices_by_barcode
    end

    def find_price(barcode)
      @prices_by_barcode[barcode]
    end
  end
end
