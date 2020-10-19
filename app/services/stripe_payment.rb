class StripePayment
  DEFAULT_CURRENCY = 'usd'.freeze

  attr_accessor :user, :email, :token, :amount
  def initialize(params, user)
    @email = user.email
    @token = params[:stripeToken]
    @amount = params[:stripeAmount]
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  def find_customer
    if user.stripe_id
      retrieve_customer(user.stripe_id)
    else
      create_customer
    end
  end

  def retrieve_customer(token)
    Stripe::Customer.retrieve(token)
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: email,
      source: token,
      address: {
        line1: 'test',
        postal_code: '98140',
        city: 'San Fransico',
        state: 'CA',
        country: 'US'
      },
      name: 'test'
    )
    user.update(stripe_id: token)
    customer
  end

  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      shipping: {
        name: 'Dipak Rathod',
        address: {
          line1: '510 Townsend St',
          postal_code: '98140',
          city: 'San Francisco',
          state: 'CA',
          country: 'US'
        }
      },
      amount: 5000,
      description: email,
      currency: 'usd'
    )
  end
end
