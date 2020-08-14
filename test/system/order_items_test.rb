require "application_system_test_case"

class OrderItemsTest < ApplicationSystemTestCase
  setup do
    @order_item = order_items(:one)
  end

  test "visiting the index" do
    visit order_items_url
    assert_selector "h1", text: "Order Items"
  end

  test "creating a Order item" do
    visit order_items_url
    click_on "New Order Item"

    fill_in "Bill date", with: @order_item.bill_date
    fill_in "Color", with: @order_item.color
    fill_in "Discount", with: @order_item.discount
    check "Fulfilled" if @order_item.fulfilled
    fill_in "Id sku", with: @order_item.id_sku
    fill_in "Order", with: @order_item.order_id
    fill_in "Order item", with: @order_item.order_item_id
    fill_in "Order number", with: @order_item.order_number
    fill_in "Price", with: @order_item.price
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    fill_in "Ship date", with: @order_item.ship_date
    fill_in "Size", with: @order_item.size
    fill_in "Total", with: @order_item.total
    click_on "Create Order item"

    assert_text "Order item was successfully created"
    click_on "Back"
  end

  test "updating a Order item" do
    visit order_items_url
    click_on "Edit", match: :first

    fill_in "Bill date", with: @order_item.bill_date
    fill_in "Color", with: @order_item.color
    fill_in "Discount", with: @order_item.discount
    check "Fulfilled" if @order_item.fulfilled
    fill_in "Id sku", with: @order_item.id_sku
    fill_in "Order", with: @order_item.order_id
    fill_in "Order item", with: @order_item.order_item_id
    fill_in "Order number", with: @order_item.order_number
    fill_in "Price", with: @order_item.price
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    fill_in "Ship date", with: @order_item.ship_date
    fill_in "Size", with: @order_item.size
    fill_in "Total", with: @order_item.total
    click_on "Update Order item"

    assert_text "Order item was successfully updated"
    click_on "Back"
  end

  test "destroying a Order item" do
    visit order_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order item was successfully destroyed"
  end
end
