# frozen_string_literal: true

# Devise Authentication Session Controller
class Users::SessionsController < Devise::SessionsController
  respond_to :html, :js
end
