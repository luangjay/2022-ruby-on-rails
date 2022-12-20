class MainController < ApplicationController
  before_action :require_login, except: %i[ login logout authenticate ]
  before_action :verify_buyer, only: %i[ my_market my_market_buy my_market_buy_post purchase_history ]
  before_action :verify_seller, only: %i[ my_inventory my_inventory_edit my_inventory_edit_post my_inventory_delete my_inventory_new my_inventory_new_post top_seller top_seller_post sale_history ]
  before_action :set_user, except: %i[ login logout authenticate ]

  def login
    if session[:uid]
      set_user
    end
  end

  def logout
    session[:uid] = nil
    redirect_to login_path
  end

  def authenticate
    u = User.find_by(email: params[:email].downcase)
    if u && u.authenticate(params[:password])
      session[:uid] = u.id
      redirect_to main_path
    else
      redirect_to login_path, notice: 'Access denied lol'
    end
  end

  def profile
  end

  def change_password
    if @user.authenticate(params[:current]) && !params[:new].blank? && 
      !params[:confirm].blank? && params[:new]==params[:confirm]
      @user.password = params[:new]
      @user.save
      redirect_to profile_path, notice: "Password successfully changed!"
    else
      redirect_to profile_path, notice: "Incorrect information given!"
    end
  end

  def index
  end

  def my_market
    @items = Item.select(:category).distinct
    if params[:filter_category]
      @markets = Market.joins(:item).where('item.enable': true).where(Item.arel_table.alias("item")[:category].matches("%#{params[:filter_category] ? params[:filter_category].downcase : nil }%"))
    else
      @markets = Market.joins(:item).where('item.enable': true)
    end
  end

  def my_market_buy
    @market = Market.find(params[:id])
    if !Item.find(@market.item_id).enable
      redirect_to main_path, notice: 'You are not authorized to view this page!'
    end
  end

  def my_market_buy_post
    @market = Market.find(params[:id])
    if !Item.find(@market.item_id).enable
      redirect_to main_path, notice: 'You are not authorized to view this page!'
    end
    inventory_params = params.require(:inventory).permit(:user_id, :seller_id, :item_id, :price, :qty)
    @market.stock -= inventory_params[:qty].to_i
    @inventory = Inventory.new(inventory_params)
    if @market.save && @inventory.save
      redirect_to my_market_path, notice: "Item successfully bought!"
    end   
  end

  def purchase_history
    @inventories = Inventory.where(user_id: session[:uid])
  end

  def sale_history
    @inventories = Inventory.where(seller_id: session[:uid])
  end

  def my_inventory
    @markets = Market.where(user_id: session[:uid])
  end

  def my_inventory_edit
    @items = Item.where(enable: true)
    @market = Market.find(params[:id])
    if @market.user_id != session[:uid]
      redirect_to main_path, notice: 'You are not authorized to view this page!'
    end
  end

  def my_inventory_edit_post
    @market = Market.find(params[:id])
    if @market.user_id != session[:uid]
      redirect_to main_path, notice: 'You are not authorized to view this page!'
    end
    market_params = params.require(:market).permit(:user_id, :item_id, :price, :stock)
    if @market.update(stock: market_params[:stock])
      redirect_to my_inventory_path, notice: "Item successfully updated!"
    end
  end

  def my_inventory_delete
    @market = Market.find(params[:id])
    if @market.user_id != session[:uid]
      redirect_to main_path, notice: 'You are not authorized to view this page!'
    end
    if @market.destroy
      redirect_to my_inventory_path, notice: "Item successfully deleted!"
    end
  end

  def my_inventory_new
    @items = Item.where(enable: true)
  end

  def my_inventory_new_post
    market_params = params.require(:market).permit(:user_id, :item_id, :price, :stock)
    @market = Market.new(market_params)
    if @market.save
      redirect_to my_inventory_path, notice: "Item successfully added!"
    end
  end

  def top_seller
    @sellers = Inventory.all
    if params[:mode]=="quantity"
      @mode = "quantity"
      @sellers = @sellers.select("SUM(qty) AS count, *")
                  .group(:seller_id)
                  .order("count DESC")
    else
      @mode = "transaction"
      @sellers = @sellers.select("COUNT(*) AS count, *")
                  .group(:seller_id)
                  .order("count DESC")
    end      
  end

  def top_seller_post
    if !params[:start_date].blank? && !params[:end_date].blank?
      @sellers = Inventory.where("created_at >= ?", params[:start_date])
                  .where("created_at <= ?", params[:end_date])
    elsif !params[:start_date].blank?
      @sellers = Inventory.where("created_at >= ?", params[:start_date])
    elsif !params[:end_date].blank?
      @sellers = Inventory.where("created_at <= ?", params[:end_date])
    else
      @sellers = Inventory.all
    end
    if params[:mode]=="quantity"
      @mode = "quantity"
      @sellers = @sellers.select("SUM(qty) AS count, *")
                  .group(:seller_id)
                  .order("count DESC")
    else
      @mode = "transaction"
      @sellers = @sellers.select("COUNT(*) AS count, *")
                  .group(:seller_id)
                  .order("count DESC")
    end
    render "top_seller"
  end

  private
    def set_user
      @user = User.find(session[:uid])
    end

    def verify_seller
      if require_user_type(0) || require_user_type(1)
        return true
      else
        redirect_to main_path, notice: 'You are not authorized to view this page!'
      end
    end

    def verify_buyer
      if require_user_type(0) || require_user_type(2)
        return true
      else
        redirect_to main_path, notice: 'You are not authorized to view this page!'
      end
    end

end
