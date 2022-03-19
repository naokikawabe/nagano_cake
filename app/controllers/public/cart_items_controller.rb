class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
      @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to public_cart_items_path
    else
      render:index
    end
  end

  def create
     @cart_item = CartItem.new(cart_item_params)
     @cart_item.customer_id = current_customer.id
     if @cart_item.save
      redirect_to public_cart_items_path
     end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
     redirect_to public_cart_items_path
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    if @cart_items.destroy_all
      redirect_to public_cart_items_path
    end
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
