require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { available_colors: @product.available_colors, available_size: @product.available_size, category_id: @product.category_id, color: @product.color, current_order: @product.current_order, discount: @product.discount, discount_available: @product.discount_available, id_sku: @product.id_sku, msrp: @product.msrp, note: @product.note, price: @product.price, product_available: @product.product_available, product_description: @product.product_description, product_id: @product.product_id, product_name: @product.product_name, quantity_per_unit: @product.quantity_per_unit, ranking: @product.ranking, reorder_level: @product.reorder_level, size: @product.size, sku: @product.sku, supplier_id: @product.supplier_id, unit_price: @product.unit_price, unit_weight: @product.unit_weight, units_in_stock: @product.units_in_stock, units_on_order: @product.units_on_order, vendor_product_id: @product.vendor_product_id } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { available_colors: @product.available_colors, available_size: @product.available_size, category_id: @product.category_id, color: @product.color, current_order: @product.current_order, discount: @product.discount, discount_available: @product.discount_available, id_sku: @product.id_sku, msrp: @product.msrp, note: @product.note, price: @product.price, product_available: @product.product_available, product_description: @product.product_description, product_id: @product.product_id, product_name: @product.product_name, quantity_per_unit: @product.quantity_per_unit, ranking: @product.ranking, reorder_level: @product.reorder_level, size: @product.size, sku: @product.sku, supplier_id: @product.supplier_id, unit_price: @product.unit_price, unit_weight: @product.unit_weight, units_in_stock: @product.units_in_stock, units_on_order: @product.units_on_order, vendor_product_id: @product.vendor_product_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
