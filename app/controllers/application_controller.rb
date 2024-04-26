class ApplicationController < ActionController::Base
  before_action :check_user
  before_action :buffet_is_required
  before_action :authenticate_owner!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def buffet_is_required
    if owner_signed_in? && current_owner.buffet.nil?
      redirect_to new_buffet_path, notice: 'Você ainda não cadastrou seu Buffet!'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
  end

  def check_user
    if customer_signed_in?
      return redirect_to root_path, notice: 'Acesso negado!'
    end
  end
end
