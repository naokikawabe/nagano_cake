class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_status)
      if @order_detail.making_status == "making"
       @order_detail.order.update(status: "making")
      elsif @order.order_details.count == @order.order_details.where(making_status: "completion").count
       @order_detail.order.update(status: "ready")
      end
    redirect_to admin_order_path(@order_detail.order)

  end

  private

  def order_detail_status
    params.require(:order_detail).permit(:making_status)
  end
end
