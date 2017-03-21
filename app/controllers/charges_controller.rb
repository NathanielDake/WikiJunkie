class ChargesController < ApplicationController
include Amount

def down_grade_to_standard
  if current_user.update(role: "standard")
    current_user.set_wikis_public
    flash[:notice] = " You have downgraded your account to standard, #{current_user.email}!"
    redirect_to root_path
  else
    flash[:alert] = "There appears to have been an error. Please try again."
  end
end

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: default_amount
    }
  end

  def create
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: default_amount,
        description: "BigMoney Membership - #{current_user.email}",
        currency: 'usd'
    )

    if charge.present? && current_user.update_attributes(role: 'premium')
      flash[:notice] = "Thanks for the payment #{current_user.email}! You can now create and edit private wikis!."
      redirect_to root_path
    else
      flash[:alert] = "There appears to have been an error. Please try again."
    end
  end


  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path



end