class ChargesController < ApplicationController
include Amount
include ChargesHelper

  def new
    new_stripe_btn_data
  end

  def create
    create_customer
    create_charge
    save_charge
  end

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
end