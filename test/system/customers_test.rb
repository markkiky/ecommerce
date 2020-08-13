require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Address1", with: @customer.address1
    fill_in "Address2", with: @customer.address2
    fill_in "Billing address", with: @customer.billing_address
    fill_in "Billing city", with: @customer.billing_city
    fill_in "Billing country", with: @customer.billing_country
    fill_in "Billing postal code", with: @customer.billing_postal_code
    fill_in "Billing region", with: @customer.billing_region
    fill_in "Building", with: @customer.building
    fill_in "Card exp mo", with: @customer.card_exp_mo
    fill_in "Card exp yr", with: @customer.card_exp_yr
    fill_in "City", with: @customer.city
    fill_in "Class", with: @customer.class
    fill_in "County", with: @customer.county
    fill_in "Credit card", with: @customer.credit_card
    fill_in "Credit card type", with: @customer.credit_card_type_id
    fill_in "Customer", with: @customer.customer_id
    fill_in "Email", with: @customer.email
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Password", with: @customer.password
    fill_in "Phone", with: @customer.phone
    fill_in "Room", with: @customer.room
    fill_in "Shipping address", with: @customer.shipping_address
    fill_in "Shipping city", with: @customer.shipping_city
    fill_in "Shipping country", with: @customer.shipping_country
    fill_in "Shipping postal code", with: @customer.shipping_postal_code
    fill_in "Shipping region", with: @customer.shipping_region
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_url
    click_on "Edit", match: :first

    fill_in "Address1", with: @customer.address1
    fill_in "Address2", with: @customer.address2
    fill_in "Billing address", with: @customer.billing_address
    fill_in "Billing city", with: @customer.billing_city
    fill_in "Billing country", with: @customer.billing_country
    fill_in "Billing postal code", with: @customer.billing_postal_code
    fill_in "Billing region", with: @customer.billing_region
    fill_in "Building", with: @customer.building
    fill_in "Card exp mo", with: @customer.card_exp_mo
    fill_in "Card exp yr", with: @customer.card_exp_yr
    fill_in "City", with: @customer.city
    fill_in "Class", with: @customer.class
    fill_in "County", with: @customer.county
    fill_in "Credit card", with: @customer.credit_card
    fill_in "Credit card type", with: @customer.credit_card_type_id
    fill_in "Customer", with: @customer.customer_id
    fill_in "Email", with: @customer.email
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Password", with: @customer.password
    fill_in "Phone", with: @customer.phone
    fill_in "Room", with: @customer.room
    fill_in "Shipping address", with: @customer.shipping_address
    fill_in "Shipping city", with: @customer.shipping_city
    fill_in "Shipping country", with: @customer.shipping_country
    fill_in "Shipping postal code", with: @customer.shipping_postal_code
    fill_in "Shipping region", with: @customer.shipping_region
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
