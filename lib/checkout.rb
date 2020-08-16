require_relative 'store'
require_relative 'order'

class Checkout
  attr_reader :order, :store

  def initialize(pricing_rules)
    @rules=pricing_rules
    @store=Store.new
    @store.load_products
    @order=Order.new
  end

  def scan(code)
    product=@store.products[code]
    if product
      @order.add_item(product)
      total
      "Продукт добавлен"
    else
      "Не найден продукт с данным кодом. Попробуйте ввести другой код." if code!='quit'
    end
  end

  def total
    @total=0.00
    @discount=0.00
    @rules.apply_rules(@order.items)
    @order.items.each do |_key, item|
      @total+=(item.unit_price*item.quantity).round(2)
      @discount+=item.discount
    end
    @total
  end
  
  def detailed_cost
    total
    puts "Общая стоимость: #{format("%.2f", @total)}€"
    puts "Ваша скидка: #{format("%.2f", @discount)}€" if @discount.positive?
    puts "Стоимость с учетом скидки: #{format("%.2f", @total-@discount)}€"
  end

  def list_products
    store.products.each { |k, v| p "Продукт: #{v.name}  код: #{k} цена: #{format("%.2f", v.price)}€" }
  end
  
  def reset_basket
    order.items.clear
    puts "Из корзины удалены все товары"
  end

  def list_order_items
    if order.items.first
      puts "Вы добавили: "
      order.items.each { |k, v| p "#{v.quantity} #{k} с ценой #{format("%.2f", v.unit_price)}€" }
    else
      puts "Нет добавленных продуктов"
    end
  end
end
