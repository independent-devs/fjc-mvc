# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  before_action :set_oauth_account

  def google_oauth2
    if @user.persisted?
      sign_in(@user)
      success_redirect
    else
      error_redirect
    end
  end

  def facebook
    if @user.persisted?
      sign_in(@user)
      success_redirect
    else
      # Removing extra as it can overflow some session stores
      session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)
      error_redirect
    end
  end

  private

  def set_oauth_account
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    case action_name
    when 'facebook'
      @provider = 'Facebook'
    when 'google_oauth2'
      @provider = 'Google'
    end
  end

  def success_redirect
    redirect_to request.env['omniauth.params']['origin'] || session['user_return_to'] || root_path
    set_flash_message(:notice, :success, kind: @provider) if is_navigational_format?
  end

  def error_redirect
    redirect_to new_user_registration_path
    return unless is_navigational_format?

    flash[:error] =
      @user&.errors&.full_messages&.first || "Something went wrong while trying to register with #{@provider}"
  end
end
