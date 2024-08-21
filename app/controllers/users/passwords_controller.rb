# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      resource.update(password_set: true)
      set_flash_message!(:notice, :updated)
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      respond_with resource
    end
  end
  
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
