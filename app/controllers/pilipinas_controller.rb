# frozen_string_literal: true

class PilipinasController < BaseController
  def cities
    province = Pilipinas::Province.find_by(name: params[:name])
    render json: province.cities
  end

  def barangays
    city = Pilipinas::City.find_by(name: params[:name])
    render json: city.barangays
  end
end
