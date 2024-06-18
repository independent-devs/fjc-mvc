# frozen_string_literal: true

OrderStatus::STATUS.each_with_index do |status, index|
  order_status = OrderStatus.create(name: status, step: index + 1)
  next unless order_status&.name == 'unfulfilled'

  OrderTag::UNFULFILLED_TAGS.each do |tag|
    OrderTag.create(name: tag, order_status:)
  end
end
