# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  attr_reader :notif_type, :message, :duration

  ICON_STYLE = {
    success: 'bg-green-600 text-green-200',
    warn: 'bg-yellow-600 text-yellow-200',
    error: 'bg-red-600 text-red-200'
  }.freeze

  def initialize(message:, notif_type: 'success', duration: '3000')
    @notif_type = notif_type
    @message = message
    @duration = duration
    super
  end

  def icon_style
    ICON_STYLE[notif_type] || ICON_STYLE[:success]
  end
end
