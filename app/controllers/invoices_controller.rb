# frozen_string_literal: true

# Invoices Controller
class InvoicesController < ApplicationController
  before_action :load_booking, only: :new
  before_action :set_invoice_details, only: %i[show download_invoice]

  # GET
  # Invoice listings
  def index; end

  # GET
  # New invoice
  def new
    @invoice = Invoice.new
  end

  # GET
  # Show Invoice
  def show; end

  # POST
  # Create invoice
  def create
    @invoice = Booking.new(invoice_params)
    if @invoice.save
      redirect_to add_payment_method_path(booking_id: @booking&.id,amount: booking&.amount)
    else
      render :new
    end
  end

  def invoice_details
    @invoice = Invoice.find_by(id: params['invoice'])
  end

  def download_invoice
    respond_to do |format|
      format.js
      format.pdf do
        render pdf: 'invoice',
               template: 'invoices/download_invoice.html.erb',
               locals: { invoice: @invoice }
      end
    end
  end

  private

  def set_invoice_details
    @invoice = Invoice.find_by(id: params[:id])
    @address = @invoice.address
    @booking = @invoice.booking
    @subscription = @invoice.subscription
    @user = @booking.present? ? @booking.user : @subscription.user
  end

  def load_booking
    @booking = Booking.find_by(id: params[:booking])
  end
end
