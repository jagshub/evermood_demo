class OrderController < ApplicationController
  def list
    @orders = Order.OPEN.all
  end

  def complete
    Order.find(params[:id]).COMPLETED!
    redirect_to order_list_path
  end

  def open_all
    Order.update_all(state: :OPEN)
    redirect_to order_list_path
  end
end
