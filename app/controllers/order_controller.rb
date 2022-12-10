class OrderController < ApplicationController
  def list
    @orders = Order.open.all
  end

  def complete
    Order.find(params[:id]).completed!
    redirect_to order_list_path
  end

  def open_all
    Order.update_all(state: :open)
    redirect_to order_list_path
  end
end
