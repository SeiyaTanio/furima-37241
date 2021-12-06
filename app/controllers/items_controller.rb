class ItemsController < ApplicationController

  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(params_item)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def params_item
    params.require(:item).permit(:item_name, :describe, :category_id, :status_id, :delivery_fee_load_id, :prefecture_id, :sending_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
