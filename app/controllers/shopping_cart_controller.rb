class ShoppingCartController < ApplicationController

  before_filter :require_login

  def index
    @cart = current_user.shopping_cart
  end

  def add_to_cart
    #debugger
    product = Product.find(params[:id])
    product.quantity -= 1
    product.save

    current_user.shopping_cart ||= ShoppingCart.create
    current_user.shopping_cart.add(product, product.price)

    redirect_to shopping_cart_index_url
  end

  def destroy
    product = Product.find(params[:id])
    current_user.shopping_cart.remove(product, 1)

    if current_user.shopping_cart.shopping_cart_items.count == 0
      current_user.shopping_cart.destroy
    end
    # debugger
    redirect_to shopping_cart_index_url
  end
end
