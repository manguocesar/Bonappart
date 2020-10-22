class StripePayment
  DEFAULT_CURRENCY = 'eur'.freeze

  attr_accessor :user, :email, :token, :amount, :params
  def initialize(params, user)
    @email = user.email
    @token = params[:stripeToken]
    @amount = params[:payment][:amount]
    @user = user
    @params = params
  end

  def call
    create_customer
  end

  private

  # Create stripe customer
  def create_customer
    customer = Stripe::Customer.create(
      email: email,
      source: token,
      address: {
        line1: params[:address][:area],
        postal_code: params[:address][:postal_code],
        city: params[:address][:city],
        state: params[:address][:state],
        country: 'France'
      },
      name: user.firstname
    )
    create_charge(customer)
  end

  # Create stripe charge for payment
  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      shipping: {
        name: user.firstname,
        address: {
          line1: params[:address][:area],
          postal_code: params[:address][:postal_code],
          city: params[:address][:city],
          state: params[:address][:state],
          country: 'France'
        }
      },
      amount: amount.to_i * 100,
      description: email,
      currency: 'eur'
    )
  end
end
