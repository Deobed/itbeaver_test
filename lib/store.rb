require_relative 'product'

class Store
  require "json"
  
  attr_reader :products

  def initialize
    @file_path="bd/produсts.json"
    @products={}
  end

  def load_products
    file=File.open root_path, 'r'
    products_hash=JSON.load file
    products_hash["products"].each do |item|
      product=Product.new(item["code"], item["name"], item["price"].to_f)
      products[product.code]=product
    end
  end

  private

  def root_path
    File.join(File.dirname(__FILE__), @file_path)
  end
end
