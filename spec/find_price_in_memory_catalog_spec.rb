require "spec_helper"
require "find_price_in_catalog_contract"
require "price"

describe "in-memory catalog" do
  it_satisfies_contract_for "find price in catalog"

  def catalog_with(barcode, price)
    InMemoryCatalog.new(
      "definitely not #{barcode}" => Price.cents(0),
      barcode => price,
      "once again, definitely not #{barcode}" => Price.cents(1000000)
    )
  end

  def catalog_without(barcode_to_avoid)
    InMemoryCatalog.new("anything but #{barcode_to_avoid}" => Price.cents(0))
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
