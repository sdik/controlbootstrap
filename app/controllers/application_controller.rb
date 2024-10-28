class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "Acesso restrito a administradores."
      redirect_to unauthorized_path   # ou outra rota de sua escolha
    end
  end
end
