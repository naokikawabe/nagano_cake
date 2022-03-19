class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end

  def update
      @order = Order.find(params[:id])
      @order.update(order_status)
      @order_details = @order.order_details
      if @order.status == "confirmation"
        @order_details.update_all(making_status: "waiting")
      end
      redirect_to admin_order_path
  end

  private

  def order_status
    params.require(:order).permit(:status)
  end

end
