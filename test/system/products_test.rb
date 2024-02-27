# frozen_string_literal: true

require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test 'visiting the index' do
    visit products_url
    assert_selector 'h1', text: 'Products'
  end

  test 'should create product' do
    visit products_url
    click_on 'New product'

    fill_in 'Available on', with: @product.available_on
    fill_in 'Deleted at', with: @product.deleted_at
    fill_in 'Description', with: @product.description
    fill_in 'Meta description', with: @product.meta_description
    fill_in 'Meta keywords', with: @product.meta_keywords
    fill_in 'Meta title', with: @product.meta_title
    fill_in 'Name', with: @product.name
    check 'Promotionable' if @product.promotionable
    fill_in 'Slug', with: @product.slug
    click_on 'Create Product'

    assert_text 'Product was successfully created'
    click_on 'Back'
  end

  test 'should update Product' do
    visit product_url(@product)
    click_on 'Edit this product', match: :first

    fill_in 'Available on', with: @product.available_on
    fill_in 'Deleted at', with: @product.deleted_at
    fill_in 'Description', with: @product.description
    fill_in 'Meta description', with: @product.meta_description
    fill_in 'Meta keywords', with: @product.meta_keywords
    fill_in 'Meta title', with: @product.meta_title
    fill_in 'Name', with: @product.name
    check 'Promotionable' if @product.promotionable
    fill_in 'Slug', with: @product.slug
    click_on 'Update Product'

    assert_text 'Product was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Product' do
    visit product_url(@product)
    click_on 'Destroy this product', match: :first

    assert_text 'Product was successfully destroyed'
  end
end
