# frozen_string_literal: true

# Invoices Controller
class InvoicesController < ApplicationController
  before_action :load_booking, only: :new
  before_action :set_invoice_details, only: %i[show preview download]

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
      redirect_to add_payment_method_path(booking_id: @booking&.id, amount: booking&.amount)
    else
      render :new
    end
  end

  def invoice_details
    @invoice = Invoice.find_by(id: params['invoice'])
  end

  def preview
    respond_to do |format|
      format.js
      format.pdf do
        render pdf: 'invoice',
               template: 'invoices/preview.html.erb',
               locals: { invoice: @invoice, booking: @invoice&.booking, apartment: @invoice&.booking&.apartment }
      end
    end
  end

  def download
    html = render_to_string('invoices/preview.html.erb', layout: false)
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,
              filename: "invoice_#{@invoice.invoice_number}",
              disposition: 'attachment')
  end

  private

  def load_invoice
    @invoice = Invoice.find_by(id: params[:id])
  end

  def set_invoice_details
    load_invoice
    @address = @invoice.address
    @booking = @invoice.booking
    @subscription = @invoice.subscription
    @user = @booking.present? ? @booking.user : @subscription.user
  end

  def load_booking
    @booking = Booking.find_by(id: params[:booking])
  end
end
