# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      redirect_to(new_user_registration_path, error: 'There was a problem signing with Google')
    end
  end

  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      # Removing extra as it can overflow some session stores
      session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to(new_user_registration_path, error: 'There was a problem signing with Google')
    end
  end
end
