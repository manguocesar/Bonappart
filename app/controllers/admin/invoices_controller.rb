# frozen_string_literal: true

# Invoices Controller
module Admin
  class InvoicesController < ApplicationController
    before_action :set_invoice_details, only: %i[show edit update destroy set_required_id]
    before_action :set_required_id, only: %i[edit]

    # Invoice listings
    def index
      @invoices = pagination(Invoice.all.order(created_at: :desc))
    end

    # New invoice
    def new
      @invoice = Invoice.new
    end

    # Get landlord specific apartments
    def landlord_properties
      fetch_user = User.find_by(id: params[:id])
      if fetch_user.present?
        apartments = fetch_user&.apartments&.pluck(:title, :id)
        render json: apartments.to_json
      end
    end

    # Edit invoice
    def edit; end

    # Show Invoice
    def show; end

    # Create invoice
    def create
      @invoice = Invoice.new(invoice_params)
      @invoice.user_id = user&.id
      @invoice.apartment_id = apartment&.id
      @invoice.booking_id = apartment.booking&.id
      @invoice.subscription_id = apartment.subscription&.id
      if @invoice.save
        redirect_to admin_invoices_path, notice: t('invoice.create')
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

    def apartment
      Apartment.find_by(id: invoice_params[:apartment_id])
    end

    def user
      User.find_by(id: invoice_params[:user_id].split.first)
    end

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
      params.require(:invoice).permit(
        %i[invoice_number date status amount subscription_id
           description vat_rate user_id apartment_id booking_id
          ]
      )
    end
  end
end
