class OffersController < ApplicationController
  
  def index
    @device = Device.find(session[:device_id])
  rescue ActiveRecord::RecordNotFound => e
    invalid_session!
  end


end