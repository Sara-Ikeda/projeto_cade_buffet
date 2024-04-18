class ApplicationController < ActionController::Base
  before_action :buffet_is_required

  protected

  def buffet_is_required
    if !current_owner.nil? && current_owner.buffet.nil?
      redirect_to new_buffet_path, notice: 'Você ainda não cadastrou seu Buffet!'
    end
  end
end
