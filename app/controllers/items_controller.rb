class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new] 
  def index

  end

  def new
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :postage_id, :shipping_date_id, :price, :prefecture_id).merge(user_id: current_user.id)

end
