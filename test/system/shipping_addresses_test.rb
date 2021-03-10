require "application_system_test_case"

class ShippingAddressesTest < ApplicationSystemTestCase
  setup do
    @shipping_address = shipping_addresses(:one)
  end

  test "visiting the index" do
    visit shipping_addresses_url
    assert_selector "h1", text: "Shipping Addresses"
  end

  test "creating a Shipping address" do
    visit shipping_addresses_url
    click_on "New Shipping Address"

    fill_in "Address", with: @shipping_address.address
    fill_in "City", with: @shipping_address.city
    fill_in "Country", with: @shipping_address.country
    fill_in "Postal code", with: @shipping_address.postal_code
    fill_in "Region", with: @shipping_address.region
    click_on "Create Shipping address"

    assert_text "Shipping address was successfully created"
    click_on "Back"
  end

  test "updating a Shipping address" do
    visit shipping_addresses_url
    click_on "Edit", match: :first

    fill_in "Address", with: @shipping_address.address
    fill_in "City", with: @shipping_address.city
    fill_in "Country", with: @shipping_address.country
    fill_in "Postal code", with: @shipping_address.postal_code
    fill_in "Region", with: @shipping_address.region
    click_on "Update Shipping address"

    assert_text "Shipping address was successfully updated"
    click_on "Back"
  end

  test "destroying a Shipping address" do
    visit shipping_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shipping address was successfully destroyed"
  end
end
