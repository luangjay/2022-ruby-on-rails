class ShopController < ApplicationController
  before_action :require_login, except: %i[show]

  def show
    @seller = User.find(params[:id])
    @items = Item.where(user_id: params[:id])
    render 'index'
  end

  def buy
    @item = Item.find(params[:id])
  end

  def transact
    @item = Item.find(params[:id])
    @item.stock -= params[:quantity].to_i
    if @item.save then end

    @inventory = Inventory.new(user_id: session[:uid], item_id: params[:id], quantity: params[:quantity].to_i, price: @item.price)
    if @inventory.save then end
    redirect_to "/shop/#{@item.user_id}", notice: 'Transaction successful!'
  end

end
