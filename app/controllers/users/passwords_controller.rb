# frozen_string_literal: true

# Devise Authentication Password Controller
class Users::PasswordsController < Devise::PasswordsController
  respond_to :html, :js
end
