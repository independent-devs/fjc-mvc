# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { available_on: @product.available_on, deleted_at: @product.deleted_at,
                                description: @product.description, meta_description: @product.meta_description,
                                meta_keywords: @product.meta_keywords, meta_title: @product.meta_title,
                                name: @product.name, promotionable: @product.promotionable, slug: @product.slug } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: { available_on: @product.available_on, deleted_at: @product.deleted_at,
                               description: @product.description, meta_description: @product.meta_description,
                               meta_keywords: @product.meta_keywords, meta_title: @product.meta_title,
                               name: @product.name, promotionable: @product.promotionable, slug: @product.slug } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
