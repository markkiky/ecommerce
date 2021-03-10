require "application_system_test_case"

class BillingAddressesTest < ApplicationSystemTestCase
  setup do
    @billing_address = billing_addresses(:one)
  end

  test "visiting the index" do
    visit billing_addresses_url
    assert_selector "h1", text: "Billing Addresses"
  end

  test "creating a Billing address" do
    visit billing_addresses_url
    click_on "New Billing Address"

    fill_in "Address", with: @billing_address.address
    fill_in "City", with: @billing_address.city
    fill_in "Country", with: @billing_address.country
    fill_in "Postal code", with: @billing_address.postal_code
    fill_in "Region", with: @billing_address.region
    click_on "Create Billing address"

    assert_text "Billing address was successfully created"
    click_on "Back"
  end

  test "updating a Billing address" do
    visit billing_addresses_url
    click_on "Edit", match: :first

    fill_in "Address", with: @billing_address.address
    fill_in "City", with: @billing_address.city
    fill_in "Country", with: @billing_address.country
    fill_in "Postal code", with: @billing_address.postal_code
    fill_in "Region", with: @billing_address.region
    click_on "Update Billing address"

    assert_text "Billing address was successfully updated"
    click_on "Back"
  end

  test "destroying a Billing address" do
    visit billing_addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Billing address was successfully destroyed"
  end
end
