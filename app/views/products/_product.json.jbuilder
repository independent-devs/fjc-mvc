# frozen_string_literal: true

json.extract! product, :id, :name, :description, :available_on, :deleted_at, :slug, :meta_description, :meta_keywords,
              :promotionable, :meta_title, :created_at, :updated_at
json.url product_url(product, format: :json)
