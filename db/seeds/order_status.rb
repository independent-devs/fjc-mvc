# frozen_string_literal: true

OrderStatus::STATUSES.each_with_index do |status, index|
  OrderStatus.create(name: status, step: index + 1)
end
