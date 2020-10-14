require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length
    item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    #binding.pry
    coupon_item = "#{coupons[counter][:item]} W/COUPON"
    cart_item_coupon = find_item_by_name_in_collection(coupon_item , cart)
    #binding.pry
    if item && item[:count] >= coupons[counter][:num]
      if cart_item_coupon
        cart_item_coupon[:count] += coupons[counter][:num]
        item[:count] -= coupons[counter][:num]
        #binding.pry
      else
        cart_item_coupon = {
            :item => coupon_item,
            :price => coupons[counter][:cost] / coupons[counter][:num],
            :clearance => item[:clearance],
            :count => coupons[counter][:num]
        }
        cart << cart_item_coupon
        item[:count] -= coupons[counter][:num]
        #binding.pry
      end
    end
    counter +=1
  end
  cart
end

def apply_clearance(cart)
  counter = 0
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = cart[counter][:price] - (cart[counter][:price] * 0.20)
    end
    counter += 1
  end
  cart
end


def checkout(cart, coupons)
  new_consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(new_consolidated_cart, coupons)
  receipt = apply_clearance(coupons_cart)

  total = 0
  counter = 0
  #binding.pry
  while counter < receipt.length
    total += receipt[counter][:price] * receipt[counter][:count]
    counter += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end