# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in(@user)
      success_redirect provider: 'Google'
    else
      error_redirect provider: 'Google'
    end
  end

  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(@user)
      success_redirect provider: 'Facebook'
    else
      # Removing extra as it can overflow some session stores
      session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)
      error_redirect provider: 'Facebook'
    end
  end

  private

  def success_redirect(provider:)
    redirect_to request.env['omniauth.params']['origin'] || session['user_return_to'] || root_path
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
  end

  def error_redirect(provider:)
    redirect_to(new_user_registration_path, error: "There was a problem signing with #{provider}")
  end
end
