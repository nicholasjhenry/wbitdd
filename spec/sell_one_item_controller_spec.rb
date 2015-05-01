describe "sale controller" do
  describe "selling one item" do
    specify "given the product is found" do
      catalog = double(:catalog)
      display = spy(:display)
      irrelevant_price = Price.cents(795)

      allow(catalog).to receive(:find_price).with("::product found::").and_return(irrelevant_price)

      sale_controller = SaleController.new(catalog, display)
      sale_controller.on_barcode("::product found::")

      expect(display).to have_received(:display_price).once.with(irrelevant_price)
    end

    specify "product not found" do
      catalog = double(:catalog)
      display = spy(:display)
      allow(catalog).to receive(:find_price).with("::product not found::").and_return(nil)

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

  class Price
    def self.cents(cents_value)
      new
    end
  end
end
