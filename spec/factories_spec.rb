# frozen_string_literal: true

# Test Factories
# This spec is useful to ensure new factories are working as expected
require 'rails_helper'

FactoryBot.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'factory valid' do
      expect(build(factory_name)).to be_valid
    end
  end
end
