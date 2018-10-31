
def get_price_suggestion_rate(rating)
  if rating == high
   return 1.1
  elsif rating == low
   return 0.9
  else
   return 1
  end
end 

def get_shopping_cost_rate(price_reference)
  if price_reference < 15
    return 0.75
  elsif price_reference < 25
    return 0.775
  elsif price_reference < 50
    return 0.8
  elsif price_reference < 75
    return 0.825
  elsif price_reference < 100
    return 0.85
  elsif price_reference < 200
    return 0.875
  elsif price_reference < 400
    return 0.9
  elsif price_reference < 600
    return 0.925
  else
    return 0.95
  end
end

def get_price_suggestion (price_reference, shipping_cost, rating)
  price_suggestion_rate = get_price_suggestion_rate rating
  shopping_cost_rate = get_shopping_cost_rate price_reference

  (price_reference - shipping_cost * shopping_cost_rate) * price_suggestion_rate
end

price_suggestion = get_price_suggestion(price_reference, product_database.shipping_cost, brand.rating)
price_original = price_suggestion