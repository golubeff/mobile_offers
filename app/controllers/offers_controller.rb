class OffersController < ApplicationController
  before_filter :load_device

  def load_device
    if params[:test]
      @device = Device.last
    else
      @device = Device.find(session[:device_id])
    end
    @user = @device.user
  rescue ActiveRecord::RecordNotFound => e
    invalid_session!
  end


end