class BulkPurchasesRule
  attr_reader :code

  def initialize(code, quantity, discount, discount_value)
    @code=code
    @quantity=quantity.to_i
    @discount=discount.to_f
    @discount_value=discount_value
  end

  def apply(item)
    if item.quantity>=@quantity
      item.discount=item.quantity*@discount if @discount_value=="abs"
      item.discount=item.quantity*item.unit_price*(@discount/100) if @discount_value=="perc"
    end
  end
end
