require "price"

describe "in-memory catalog" do
  describe "find price" do
    specify "product found" do
      found_price = Price.cents(1250)
      catalog = catalog_with("12345", found_price)

      expect(catalog.find_price("12345")).to eq(found_price)
    end

    specify "product not found" do
      expect(catalog_without("12345").find_price("12345")).to be_nil
    end
  end

  def catalog_with(barcode, price)
    InMemoryCatalog.new(barcode => price)
  end

  def catalog_without(barcode_to_avoid)
    InMemoryCatalog.new({})
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
