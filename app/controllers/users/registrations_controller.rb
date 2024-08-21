# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :require_no_authentication, only: [:new, :create], unless: :admin_signed_in?

  private

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  def require_no_authentication
    if !admin_signed_in?
      super
    end
  end
  # before_action :authenticate_user!
  # before_action :require_admin

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   @user.password_set = false # Sinaliza que o usuário ainda não definiu a senha

  #   if @user.save
  #     redirect_to users_path, notice: 'Usuário criado com sucesso. Ele deverá definir a senha no primeiro acesso.'
  #   else
  #     render :new
  #   end
  # end

  # private

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path, alert: 'Acesso não autorizado.'
  #   end
  # end

  # def user_params
  #   params.require(:user).permit(:email, :role)
  # end
 
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
