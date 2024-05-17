class OrdersController < ApplicationController
  skip_before_action :authenticate_owner!
  before_action :check_user, except: [:index, :show]
  before_action :authenticate_customer!, except: [:index, :show]
  
  def index
    @orders = current_owner.buffet.orders if owner_signed_in?
    @orders = current_customer.orders if customer_signed_in?
  end

  def show
    if owner_signed_in?
      @order = current_owner.buffet.orders.find(params[:id])
      
      @conflict_dates_orders = current_owner.buffet.orders.where(
                              "date = ? AND code != ?", @order.date, @order.code)
    elsif customer_signed_in?
      @order = current_customer.orders.find(params[:id])
      flash.now[:notice] = 'O pedido foi aprovado pelo Buffet. Confirme o orçamento.' if @order.approved?
      flash.now[:notice] = 'A data limite para confirmação expirou.' if @order.canceled? && @order.order_budget.present?
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @buffet = @event.buffet
    @order = @buffet.orders.build
  end

  def create
    @event = Event.find(params[:event_id])
    @buffet = @event.buffet
    order_params = params.require(:order).permit(:date, :number_of_guests, :other_details, :address)

    @order = current_customer.orders.build(order_params)
    @order.event = @event
    @order.buffet = @buffet
    
    if @order.save
      redirect_to @buffet, notice: 'Pedido cadastrado com sucesso. Acompanhe-o em Meus Pedidos.'
    else
      flash.now[:notice] = 'Não foi possível fazer o pedido.'
      render 'new'
    end
  end

  def confirm
    @order = current_customer.orders.find(params[:id])
    @order.confirmed!

    redirect_to order_path(@order), notice: "Pedido #{@order.code} Confirmado"
  end

  private

  def check_user
    if owner_signed_in?
      return redirect_to root_path, notice: 'Acesso negado!'
    end
  end
end