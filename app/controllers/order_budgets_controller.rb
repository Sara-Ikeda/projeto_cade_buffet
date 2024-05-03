class OrderBudgetsController < ApplicationController
  def new
    @order = current_owner.buffet.orders.find(params[:order_id])
    @order_budget = @order.build_order_budget
  end

  def create
    order_budget_params = params.require(:order_budget).permit(:deadline, :rate,
                          :rate_value, :rate_description, :payment_options)
    
    @order = current_owner.buffet.orders.find(params[:order_id])
    @order_budget = @order.create_order_budget(order_budget_params)

    if @order_budget.save
      @order.approved!
      redirect_to order_index_buffets_path, notice: 'Pedido Aprovado. Esperando Confirmação do Cliente.'
    else
      flash.now[:notice] = 'Não foi possível aprovar o pedido.'
      render 'new'
    end
  end
end