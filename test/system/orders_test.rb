require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Customer", with: @order.customer_id
    check "Deleted" if @order.deleted
    fill_in "Err loc", with: @order.err_loc
    fill_in "Err msg", with: @order.err_msg
    fill_in "Freight", with: @order.freight
    check "Fulfilled" if @order.fulfilled
    fill_in "Order date", with: @order.order_date
    fill_in "Order", with: @order.order_id
    fill_in "Order number", with: @order.order_number
    fill_in "Order total", with: @order.order_total
    check "Paid" if @order.paid
    fill_in "Payment date", with: @order.payment_date
    fill_in "Payment", with: @order.payment_id
    fill_in "Required date", with: @order.required_date
    fill_in "Sales tax", with: @order.sales_tax
    fill_in "Ship date", with: @order.ship_date
    fill_in "Shipper date", with: @order.shipper_date
    fill_in "Timestamp", with: @order.timestamp
    fill_in "Transact status", with: @order.transact_status
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @order.customer_id
    check "Deleted" if @order.deleted
    fill_in "Err loc", with: @order.err_loc
    fill_in "Err msg", with: @order.err_msg
    fill_in "Freight", with: @order.freight
    check "Fulfilled" if @order.fulfilled
    fill_in "Order date", with: @order.order_date
    fill_in "Order", with: @order.order_id
    fill_in "Order number", with: @order.order_number
    fill_in "Order total", with: @order.order_total
    check "Paid" if @order.paid
    fill_in "Payment date", with: @order.payment_date
    fill_in "Payment", with: @order.payment_id
    fill_in "Required date", with: @order.required_date
    fill_in "Sales tax", with: @order.sales_tax
    fill_in "Ship date", with: @order.ship_date
    fill_in "Shipper date", with: @order.shipper_date
    fill_in "Timestamp", with: @order.timestamp
    fill_in "Transact status", with: @order.transact_status
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
