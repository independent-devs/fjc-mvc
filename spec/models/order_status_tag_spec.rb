# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderStatusTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: order_status_tags
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#  order_tag_id :bigint           not null
#
# Indexes
#
#  index_order_status_tags_on_order_id      (order_id)
#  index_order_status_tags_on_order_tag_id  (order_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (order_tag_id => order_tags.id)
#
