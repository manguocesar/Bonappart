class StripePayment
  DEFAULT_CURRENCY = 'usd'.freeze

  attr_accessor :user, :email, :token, :amount, :params
  def initialize(params, user)
    @email = user.email
    @token = params[:stripeToken]
    @amount = params[:stripeAmount]
    @user = user
    @params = params
  end

  def call
    create_customer
  end

  private

  def create_customer
    customer = Stripe::Customer.create(
      email: email,
      source: token,
      address: {
        line1: params[:address][:address],
        postal_code: params[:address][:postal_code],
        city: params[:address][:city],
        state: params[:address][:state],
        country: params[:address][:country]
      },
      name: user.firstname
    )
    create_charge(customer)
  end

  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      shipping: {
        name: user.firstname,
        address: {
          line1: params[:address][:address],
          postal_code: params[:address][:postal_code],
          city: params[:address][:city],
          state: params[:address][:state],
          country: params[:address][:country]
        }
      },
      amount: 5000,
      description: email,
      currency: 'eur'
    )
  end
end
