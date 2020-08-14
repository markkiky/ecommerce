require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Available colors", with: @product.available_colors
    fill_in "Available size", with: @product.available_size
    fill_in "Category", with: @product.category_id
    fill_in "Color", with: @product.color
    fill_in "Current order", with: @product.current_order
    fill_in "Discount", with: @product.discount
    fill_in "Discount available", with: @product.discount_available
    fill_in "Id sku", with: @product.id_sku
    fill_in "Msrp", with: @product.msrp
    fill_in "Note", with: @product.note
    fill_in "Price", with: @product.price
    fill_in "Product available", with: @product.product_available
    fill_in "Product description", with: @product.product_description
    fill_in "Product", with: @product.product_id
    fill_in "Product name", with: @product.product_name
    fill_in "Quantity per unit", with: @product.quantity_per_unit
    fill_in "Ranking", with: @product.ranking
    fill_in "Reorder level", with: @product.reorder_level
    fill_in "Size", with: @product.size
    fill_in "Sku", with: @product.sku
    fill_in "Supplier", with: @product.supplier_id
    fill_in "Unit price", with: @product.unit_price
    fill_in "Unit weight", with: @product.unit_weight
    fill_in "Units in stock", with: @product.units_in_stock
    fill_in "Units on order", with: @product.units_on_order
    fill_in "Vendor product", with: @product.vendor_product_id
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Available colors", with: @product.available_colors
    fill_in "Available size", with: @product.available_size
    fill_in "Category", with: @product.category_id
    fill_in "Color", with: @product.color
    fill_in "Current order", with: @product.current_order
    fill_in "Discount", with: @product.discount
    fill_in "Discount available", with: @product.discount_available
    fill_in "Id sku", with: @product.id_sku
    fill_in "Msrp", with: @product.msrp
    fill_in "Note", with: @product.note
    fill_in "Price", with: @product.price
    fill_in "Product available", with: @product.product_available
    fill_in "Product description", with: @product.product_description
    fill_in "Product", with: @product.product_id
    fill_in "Product name", with: @product.product_name
    fill_in "Quantity per unit", with: @product.quantity_per_unit
    fill_in "Ranking", with: @product.ranking
    fill_in "Reorder level", with: @product.reorder_level
    fill_in "Size", with: @product.size
    fill_in "Sku", with: @product.sku
    fill_in "Supplier", with: @product.supplier_id
    fill_in "Unit price", with: @product.unit_price
    fill_in "Unit weight", with: @product.unit_weight
    fill_in "Units in stock", with: @product.units_in_stock
    fill_in "Units on order", with: @product.units_on_order
    fill_in "Vendor product", with: @product.vendor_product_id
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
