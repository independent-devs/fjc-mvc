# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: payment_methods
#
#  id          :uuid             not null, primary key
#  code        :string           not null
#  credentials :json
#  enable      :boolean          default(FALSE), not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payment_methods_on_code  (code) UNIQUE
#  index_payment_methods_on_name  (name)
#
