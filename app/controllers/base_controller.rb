# frozen_string_literal: true

class BaseController < ApplicationController
  def set_guest_session
    if cookies.signed[:guest_session].blank?
      cookies.signed.permanent[:guest_session] = (@guest_session = GuestSession.create).id
    elsif (@guest_session = GuestSession.find_by(id: cookies.signed[:guest_session]) || GuestSession.create).new_record?
      cookies.delete :guest_session
      cookies.signed.permanent[:guest_session] = @guest_session.id
    end
  end
end
