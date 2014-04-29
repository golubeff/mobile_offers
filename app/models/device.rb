class Device < ActiveRecord::Base
  ALLOWED_ATTRIBUTES = [ :os, :uuid, :model, :ifa, :mac ]

  belongs_to :user
  # include Tokenable

  def serializable_hash(options=nil)
    { id: id }
  end
end