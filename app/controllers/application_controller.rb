class ApplicationController < ActionController::Base
  before_action :buffet_is_required
  before_action :authenticate_owner!

  protected

  def buffet_is_required
    if owner_signed_in? && current_owner.buffet.nil?
      redirect_to new_buffet_path, notice: 'Você ainda não cadastrou seu Buffet!'
    end
  end
end
