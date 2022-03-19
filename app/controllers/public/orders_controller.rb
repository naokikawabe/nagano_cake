class Public::OrdersController < ApplicationController
  def new
    @cart_item = current_customer.cart_items
    if @cart_item.count != 0
      @order = Order.new
      @address = current_customer.address
    else
      redirect_to public_cart_items_path
    end
  end

  def confirmation
    @shipping_cost = 800
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @address_type = params[:order][:address_type]
    if @address_type == "A"
      @postal_code = current_customer.postal_code
      @address = current_customer.address
      @name = current_customer.last_name+current_customer.first_name
    elsif @address_type == "B"
      @address_record = Address.find(params[:order][:address_id])
      @postal_code = @address_record.postal_code
      @address = @address_record.address
      @name = @address_record.name
    else
      @postal_code = params[:order][:postal_code]
      @address = params[:order][:address]
      @name = params[:order][:name]
    end
  end

  def create
    order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    order.customer_id = current_customer.id
    order.status = 0
    order.save
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price
        order_detail.making_status = 0
        order_detail.save
      end
    @cart_items.destroy_all
    redirect_to public_thanks_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
    @shipping_cost = 800
  end

  def show
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end


  private

  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :payment_method, :total_payment)
  end

end
