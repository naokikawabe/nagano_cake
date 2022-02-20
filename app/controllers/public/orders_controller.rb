class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    #@address = current_customer.address
  end

  def confirmation
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @address_type = params[:order][:address_type]
    if @address_type == "A"
      @postal_code = current_customer.postal_code
      @address = current_customer.address
    #elsif @address_type == "B"
     # @address =
    else
      @postal_code = params[:order][:postal_code]
      @address = params[:order][:address]
    end
  end

  def create
    @order = Order.new
    @cart_items = current_customer.cart_items

  end

  def thanks
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :payment_method)
  end

end
