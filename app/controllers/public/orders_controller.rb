class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.address
  end

  def confirmation
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
    if order.save
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

  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :payment_method)
  end

end
