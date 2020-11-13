# frozen_string_literal: true

module Landlord
  # Invoices Controller
  class InvoicesController < InvoicesController
    before_action :load_booking, only: :new
    before_action :set_invoice_details, only: %i[show download_invoice]

    # GET
    # Invoice listings
    def index
      @invoices = pagination(current_user.invoices.order('created_at DESC')).per(12)
    end

    # GET
    # Show Invoice
    def show; end

    def invoice_details
      @invoice = Invoice.find_by(id: params['invoice'])
    end

    def download_invoice
      respond_to do |format|
        format.js
        format.pdf do
          render pdf: 'invoice',
                 template: 'invoices/download_invoice.pdf.erb',
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
end
