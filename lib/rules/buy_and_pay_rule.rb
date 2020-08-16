class BuyAndPayRule
  attr_reader :code

  def initialize(code, quantity, free)
    @code=code
    @quantity=quantity.to_i
    @free=free.to_i
  end

  def apply(item)
    free_quantity=(item.quantity/@quantity)*@free
    item.discount=item.unit_price*free_quantity if item.quantity>=@quantity
  end
end
