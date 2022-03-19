class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
   if @customer.update(customer_params)
    redirect_to public_customers_path
   end
  end

  def confirmation
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

end
