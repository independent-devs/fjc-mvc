# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  attr_reader :notif_type, :message, :duration

  def initialize(message:, notif_type: 'success', duration: '3000')
    @notif_type = notif_type
    @message = message
    @duration = duration
    super
  end
end
