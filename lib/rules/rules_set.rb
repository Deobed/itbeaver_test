require_relative 'buy_and_pay_rule'
require_relative 'bulk_purchases_rule'

class RulesSet
  attr_reader :pricing_rules

  def initialize
    @file_path="../bd/rules.json"
    @pricing_rules=[]
    load_rules
  end

  def load_rules
    file=File.open root_path, 'r'
    rules_hash=JSON.load file
    rules_hash["rules"]["bulk_purchases"].each do |current_rule|
      @pricing_rules<<BulkPurchasesRule.new(current_rule["code"], current_rule["quantity"], current_rule["discount"], current_rule["discount_value"])
    end
    rules_hash["rules"]["buy_and_pay"].each do |current_rule|
      @pricing_rules<<BuyAndPayRule.new(current_rule["code"], current_rule["quantity"], current_rule["free"])
    end
  end

  def apply_rules(items)
    items.map do |code, item|
      @pricing_rules.each do |rule|
        code==rule.code ? rule.apply(item) : next
      end
    end
  end 

  private

  def root_path
    File.join(File.dirname(__FILE__), @file_path)
  end
end
