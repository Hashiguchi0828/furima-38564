class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new] 
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :postage_id, :shipping_date_id, :price, :prefecture_id).merge(user_id: current_user.id)
  end
end
