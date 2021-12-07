class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params_item)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    unless user_signed_in? && current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(params_item)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def params_item
    params.require(:item).permit(:item_name, :describe, :category_id, :status_id, :delivery_fee_load_id, :prefecture_id, :sending_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
