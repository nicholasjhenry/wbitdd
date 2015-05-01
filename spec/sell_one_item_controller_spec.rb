describe "sale controller" do
  describe "selling one item" do
    specify "given the product is found" do
      catalog = double(:catalog)
      display = spy(:display)
      irrelevant_price = Price.cents(795)

      allow(catalog).to receive(:find_price).with("12345").and_return(irrelevant_price)

      sale_controller = SaleController.new(catalog, display)
      sale_controller.on_barcode("12345")

      expect(display).to have_received(:display_price).once.with(irrelevant_price)
    end
  end

  class SaleController
    def initialize(catalog, display)
      @catalog = catalog
      @display = display
    end

    def on_barcode(barcode)
      @display.display_price(@catalog.find_price(barcode))
    end
  end

  class Price
    def self.cents(cents_value)
      new
    end
  end
end
