# frozen_string_literal: true

# Dashboard controller
class DashboardController < ApplicationController

  def index
  	if current_user.has_role? :admin
  	  render 'admin_dashboard'
		elsif current_user.has_role? :landlord
	   	render 'landloard_dashboard'
		else
	  	redirect_to apartments_path
		end
 	end
end
