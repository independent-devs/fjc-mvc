# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def auth_icon(auth)
    case auth
    when 'email'
      icon('fa-regular', 'envelop')
    when 'phone'
      icon('fa-solid', 'phone')
    when 'google_oauth2'
      icon('fa-brands', 'google')
    when 'facebook'
      icon('fa-brands', 'facebook')
    end
  end
end
