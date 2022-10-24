class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]

  def index
    if user_signed_in? && current_user.id != @item.user_id && @item.buyer == nil
    @buyer_form = BuyerForm.new
  else
    redirect_to root_path
  end
  end

  def create
    @buyer_form = BuyerForm.new(buyer_params)
    if @buyer_form.valid?
      pay_item
      @buyer_form.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_form).permit(:postal_code, :prefecture_id, :city, :address, :apartment, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end
  def non_purchased_item
    # itemがあっての、order_form（入れ子構造）。他のコントローラーで生成されたitemを使うにはcreateアクションに定義する。
    @item = Item.find(params[:item_id])
  end
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
        amount: @item.price,
        card: buyer_params[:token],
        currency: 'jpy'
      )
    end
end
