require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { customer_id: @order.customer_id, deleted: @order.deleted, err_loc: @order.err_loc, err_msg: @order.err_msg, freight: @order.freight, fulfilled: @order.fulfilled, order_date: @order.order_date, order_id: @order.order_id, order_number: @order.order_number, order_total: @order.order_total, paid: @order.paid, payment_date: @order.payment_date, payment_id: @order.payment_id, required_date: @order.required_date, sales_tax: @order.sales_tax, ship_date: @order.ship_date, shipper_date: @order.shipper_date, timestamp: @order.timestamp, transact_status: @order.transact_status } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { customer_id: @order.customer_id, deleted: @order.deleted, err_loc: @order.err_loc, err_msg: @order.err_msg, freight: @order.freight, fulfilled: @order.fulfilled, order_date: @order.order_date, order_id: @order.order_id, order_number: @order.order_number, order_total: @order.order_total, paid: @order.paid, payment_date: @order.payment_date, payment_id: @order.payment_id, required_date: @order.required_date, sales_tax: @order.sales_tax, ship_date: @order.ship_date, shipper_date: @order.shipper_date, timestamp: @order.timestamp, transact_status: @order.transact_status } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
