require "spec_helper"
require "find_price_in_catalog_contract"
require "price"

describe "sale controller" do
  describe "selling one item" do
    specify "product is found" do
      display = spy(:display)
      irrelevant_price = Price.cents(795)
      catalog = catalog_with("::product found::", irrelevant_price)

      sale_controller = SaleController.new(catalog, display)
      sale_controller.on_barcode("::product found::")

      expect(display).to have_received(:display_price).once.with(irrelevant_price)
    end

    specify "product not found" do
      display = spy(:display)
      catalog = catalog_without("::product not found::")

      sale_controller = SaleController.new(catalog, display)
      sale_controller.on_barcode("::product not found::")

      expect(display).to have_received(:display_product_not_found_message).once.with("::product not found::")
    end

    specify "empty barcode" do
      display = spy(:display)

      sale_controller = SaleController.new(nil, display)
      sale_controller.on_barcode("")

      expect(display).to have_received(:display_empty_bar_code_message).once
    end
  end

  describe "verifying contract for catalog" do
    it_satisfies_contract_for "find price in catalog"
  end

  def catalog_with(barcode, price)
    catalog = double(:catalog)
    allow(catalog).to receive(:find_price).with(barcode).and_return(price)
    catalog
  end

  def catalog_without(barcode_to_avoid)
    catalog = double(:catalog)
    allow(catalog).to receive(:find_price).with(barcode_to_avoid).and_return(nil)
    catalog
  end

  class SaleController
    def initialize(catalog, display)
      @catalog = catalog
      @display = display
    end

    def on_barcode(barcode)
      # SMELL Should I get an empty barcode at all?
      if barcode.empty?
        @display.display_empty_bar_code_message
        return
      end

      price = @catalog.find_price(barcode)

      if price.nil?
        @display.display_product_not_found_message(barcode)
      else
        @display.display_price(price)
      end
    end
  end
end
