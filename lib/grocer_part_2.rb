require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  cart.each do |item|
    coupons.each do |coupon|
      
      if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
      cart << {:item => "#{item[:item]} W/COUPON",
               :price => (coupon[:cost] / coupon[:num]), 
               :clearance => item[:clearance],
               :count => coupon[:num]
           } 
           item[:count] -= coupon[:num]
      end
  
    end
  end
  cart
end


def apply_clearance(cart)
    cart.each do |item|
      if item[:clearance]
        item[:price] = (item[:price] - (item[:price] * 0.2))
      end
    end
  cart
end


def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each do |item|
    total += (item[:price] * item[:count])
  end
  
  if total >= 100
    total = (total - (total * 0.1))
  end
  
  total
end
