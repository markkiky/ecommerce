require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_item = order_items(:one)
  end

  test "should get index" do
    get order_items_url
    assert_response :success
  end

  test "should get new" do
    get new_order_item_url
    assert_response :success
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post order_items_url, params: { order_item: { bill_date: @order_item.bill_date, color: @order_item.color, discount: @order_item.discount, fulfilled: @order_item.fulfilled, id_sku: @order_item.id_sku, order_id: @order_item.order_id, order_item_id: @order_item.order_item_id, order_number: @order_item.order_number, price: @order_item.price, product_id: @order_item.product_id, quantity: @order_item.quantity, ship_date: @order_item.ship_date, size: @order_item.size, total: @order_item.total } }
    end

    assert_redirected_to order_item_url(OrderItem.last)
  end

  test "should show order_item" do
    get order_item_url(@order_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_item_url(@order_item)
    assert_response :success
  end

  test "should update order_item" do
    patch order_item_url(@order_item), params: { order_item: { bill_date: @order_item.bill_date, color: @order_item.color, discount: @order_item.discount, fulfilled: @order_item.fulfilled, id_sku: @order_item.id_sku, order_id: @order_item.order_id, order_item_id: @order_item.order_item_id, order_number: @order_item.order_number, price: @order_item.price, product_id: @order_item.product_id, quantity: @order_item.quantity, ship_date: @order_item.ship_date, size: @order_item.size, total: @order_item.total } }
    assert_redirected_to order_item_url(@order_item)
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete order_item_url(@order_item)
    end

    assert_redirected_to order_items_url
  end
end
