# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: orders
#
#  id                :uuid             not null, primary key
#  cancelled_at      :datetime
#  cancelled_by      :text
#  internal_note     :text
#  logistic_name     :string
#  logistic_ref      :string
#  logistic_url      :string
#  placed_at         :datetime
#  refund_amount     :decimal(10, 2)
#  refund_reason     :text
#  return_reason     :text
#  shipping_fee      :decimal(10, 2)   default(0.0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  guest_session_id  :uuid
#  order_status_id   :uuid             not null
#  payment_method_id :uuid
#  user_id           :uuid
#
# Indexes
#
#  index_orders_on_guest_session_id   (guest_session_id)
#  index_orders_on_order_status_id    (order_status_id)
#  index_orders_on_payment_method_id  (payment_method_id)
#  index_orders_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (payment_method_id => payment_methods.id)
#  fk_rails_...  (user_id => users.id)
#
