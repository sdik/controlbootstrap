class Admin::UsersController < ApplicationController
  before_action :check_admin
  before_action :authenticate_user! # Assegura que apenas usuários logados podem acessar
  before_action :set_user, only: [:destroy, :toggle_status]

  def index
    @users = User.all.order(:id)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'Usuário excluído com sucesso.'
  end

  def toggle_status
    if (@user.admin?)
        @user.update(role: 'user')
    else
       @user.update(role: 'admin')
    end
    redirect_to admin_users_path, notice: 'Status atualizado com sucesso.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def check_admin
    redirect_to root_path, alert: 'Acesso negado.' unless current_user.role == 'admin'
  end
end
