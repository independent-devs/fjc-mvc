# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def currency_list
    Money::Currency.table.map do |cu|
      ["#{cu[1][:iso_code]} (#{cu[1][:symbol]})", cu[1][:iso_code]]
    end
  end
end
