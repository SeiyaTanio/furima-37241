class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item

  def index
    @order_address = OrderAddress.new
    if @item.order != nil || current_user.id == @item.user_id
      redirect_to root_path
    end
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
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipalities, :house_number, :building_name, :tel_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
