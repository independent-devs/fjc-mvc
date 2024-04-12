# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seo, type: :model do
  let(:seo) { create(:seo) }

  it 'create seo' do
    expect(seo.meta_title).to be_present
    expect(seo.meta_description).to be_present
    expect(seo.meta_keywords).to be_present
    expect(seo.product).to be_present
  end
end
