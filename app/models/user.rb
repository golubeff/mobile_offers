class User < ActiveRecord::Base
  class ParameterSanitizer < Devise::ParameterSanitizer
    def attributes_for(kind)
      case kind
      when :sign_in
        auth_keys + [:email, :password]
      when :sign_up
        auth_keys + [:password, :password_confirmation,:device_attributes => [ Device::ALLOWED_ATTRIBUTES ]]
      when :account_update
        auth_keys + [:password, :password_confirmation, :current_password]
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :devices, dependent: :destroy
  accepts_nested_attributes_for :devices

  has_one :device
  accepts_nested_attributes_for :device

  def serializable_hash(options=nil)
    { id: id, email: email, optin: optin, device: preferred_device }
  end

  def optin
    return "doi" if self.confirmed? 
    return "soi"
  end

  def prefer_device!(val)
    @preferred_device = val
  end

  def preferred_device
    @preferred_device || device
  end
end
