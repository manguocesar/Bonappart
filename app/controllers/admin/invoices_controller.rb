# frozen_string_literal: true

# Invoices Controller
module Admin
  class InvoicesController < ApplicationController
    before_action :set_invoice_details, only: %i[show edit update destroy set_required_id]
    before_action :set_required_id, only: %i[new edit]

    # Invoice listings
    def index
      @invoices = pagination(Invoice.all)
    end

    # New invoice
    def new
      @invoice = Invoice.new
    end

    # Edit invoice
    def edit; end

    # Show Invoice
    def show; end

    # Create invoice
    def create
      @invoice = Invoice.new(invoice_params)
      if @invoice.save
        redirect_to add_payment_method_path(booking_id: @booking&.id, amount: booking&.amount)
      else
        render :new
      end
    end

    # Update invoice
    def update
      if @invoice.update(invoice_params)
        redirect_to admin_invoices_path, notice: t('invoice.update')
      else
        render :edit
      end
    end

    # Delete invoice
    def destroy
      @invoice.destroy
      redirect_to admin_invoices_path, notice: t('invoice.delete')
    end

    private

    def set_required_id
      @booking_id = Booking.find_by(id: @invoice.booking_id)
      @subscription_id = Subscription.find_by(id: @invoice.subscription_id)
    end

    def set_invoice_details
      @invoice = Invoice.find_by(id: params[:id])
      @address = @invoice.address
      @booking = @invoice.booking
      @subscription = @invoice.subscription
      @user = @booking.present? ? @booking.user : @subscription.user
    end

    def invoice_params
      params.require(:invoice).permit(%i[invoice_number date status amount booking_id subscription_id])
    end
  end
end
