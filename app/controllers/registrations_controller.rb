class RegistrationsController < Devise::RegistrationsController
  before_filter :check_if_user_exists, :only => :create, if: :devise_controller?
  before_filter :create_password, :only => :create, if: :devise_controller?

  respond_to :json

  def create_password
    params[:user] ||= {}
    @password = params[:user][:password_confirmation] = params[:user][:password] = Devise.friendly_token.first(8)
  end

  def devise_parameter_sanitizer
    User::ParameterSanitizer.new(User, :user, params)
  end

  def check_if_user_exists
    if params[:user] && params[:user][:email]
      scope = User.where(email: params[:user][:email])
      if scope.exists?
        user = scope.first

        device_attr = params[:user][:device_attributes].permit(Device::ALLOWED_ATTRIBUTES)
        
        devices_scope = Device.where(device_attr.update :user_id => user.id)
        device = nil
        if devices_scope.exists?
          device = devices_scope.first
        else
          device = user.devices.create(device_attr)
        end

        user.prefer_device!(device)
        respond_with user
      end
    end
  end

end
