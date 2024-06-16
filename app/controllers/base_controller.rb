# frozen_string_literal: true

class BaseController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :unauthorized }
      format.html { redirect_to root_path, alert: exception.message }
      format.turbo_stream { render 'errors/unauthorized', status: :unauthorized }
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, @guest_session)
  end

  def set_guest_session
    if cookies.signed[:guest_session].blank?
      cookies.signed.permanent[:guest_session] = (@guest_session = GuestSession.create).id
    elsif (@guest_session = GuestSession.find_by(id: cookies.signed[:guest_session]) || GuestSession.create).new_record?
      cookies.delete :guest_session
      cookies.signed.permanent[:guest_session] = @guest_session.id
    end
  end
end
