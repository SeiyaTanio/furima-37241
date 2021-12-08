class OrdersController < ApplicationController

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipalities, :house_number, :building_name, :tel_number, :order_id).merge(user_id: current_user.id, item_id: params[:id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ""
    Payjp::Charge.create(
      amoust: order_params[:item_id].price
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
