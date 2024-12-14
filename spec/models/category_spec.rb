# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'Test Tree' do
    base_category = create(:category)

    clothes = create(:category, name: 'Clothes', parent: base_category)
    polo = create(:category, name: 'Polo Shirt', parent: clothes)
    tshirt = create(:category, name: 'T-Shirt', parent: clothes)

    expect(clothes.ancestor_ids).to include(base_category.id)
    expect(polo.ancestor_ids).to include(base_category.id, clothes.id)
    expect(tshirt.ancestor_ids).to include(base_category.id, clothes.id)
  end
end

# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  ancestry       :string
#  ancestry_depth :integer          default(0)
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#
