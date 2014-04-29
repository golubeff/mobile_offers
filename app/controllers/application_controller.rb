class InvalidSession < Exception; end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from InvalidSession, with: :invalid_session

  def invalid_session
    render :text => "invalid session", :status => 403
  end

  def invalid_session!
    raise InvalidSession
  end
end
