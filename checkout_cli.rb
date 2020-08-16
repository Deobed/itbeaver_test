require 'require_all'
require_all 'lib'

pricing_rules=RulesSet.new
co=Checkout.new(pricing_rules)

def help
  puts 'Справка по процессу оформления заказа
  Опции:
    list - Вывод списка доступных продуктов
    status - Проверка состояния Вашего заказа
    scan - Сканирование продуктов
    total - Получение полной информации по Вашему заказу
    reset - Удалить все товары из корзины
    quit - Выход в предыдущее меню
    help - Получение справки'
end

help
option='i'
while option!='quit'
  print '> '
  option=gets.chomp.to_s
  case option
  when 'list'
    co.list_products
  when 'status'
    co.list_order_items
  when 'scan'
    puts 'Введите каждый код через Enter:'
    code=''
    while code!='quit'
      print '>>'
      code=gets.chomp.to_s
      puts co.scan(code) if code.length>1
    end
    option='i'
  when 'total'
    co.detailed_cost    
  when 'reset'
    co.reset_basket
  when 'quit'
    puts 'Выход'
  when 'help'
    help
  end
end
