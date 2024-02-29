# frozen_string_literal: true

class OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      success(@user, 'Google')
    else
      failure('Google')
    end
  end

  def success(user, provider)
    sign_in_and_redirect(user)
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
  end

  def failure(provider)
    flash[:error] = "There was a problem signing with #{provider}."
    redirect_to(new_user_registration_path)
  end
end
