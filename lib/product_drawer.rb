class ProductDrawer
  def self.draw(products)
    pdf = PDF::Writer.new
    products.each do |product|
      pdf.text product.name
    end
    pdf.render
  end
end