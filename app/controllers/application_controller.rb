class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_in_path_for(resource)
  #   if resource == Customer
  #     public_customers_path
  #   else
  #     admin_path
  #   end

  # end

  # def after_sign_out_pash_for(resource)
  #   if admin_signed_out?
  #     new_admin_session_path
  #   end
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number])
  end
end
