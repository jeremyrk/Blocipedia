class ChargesController < ApplicationController

  def new
  end

  def create
    #Amount in cents
    @amount = 999

    customer = Stripe::Customer.create(
      :email => 'jeremy.rkw@gmail.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Jeremy\'s client',
      :currency    => 'usd'
    )

    #current_user.update_attribute("premium", true)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
