require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { address1: @customer.address1, address2: @customer.address2, billing_address: @customer.billing_address, billing_city: @customer.billing_city, billing_country: @customer.billing_country, billing_postal_code: @customer.billing_postal_code, billing_region: @customer.billing_region, building: @customer.building, card_exp_mo: @customer.card_exp_mo, card_exp_yr: @customer.card_exp_yr, city: @customer.city, class: @customer.class, county: @customer.county, credit_card: @customer.credit_card, credit_card_type_id: @customer.credit_card_type_id, customer_id: @customer.customer_id, email: @customer.email, first_name: @customer.first_name, last_name: @customer.last_name, password: @customer.password, phone: @customer.phone, room: @customer.room, shipping_address: @customer.shipping_address, shipping_city: @customer.shipping_city, shipping_country: @customer.shipping_country, shipping_postal_code: @customer.shipping_postal_code, shipping_region: @customer.shipping_region } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { address1: @customer.address1, address2: @customer.address2, billing_address: @customer.billing_address, billing_city: @customer.billing_city, billing_country: @customer.billing_country, billing_postal_code: @customer.billing_postal_code, billing_region: @customer.billing_region, building: @customer.building, card_exp_mo: @customer.card_exp_mo, card_exp_yr: @customer.card_exp_yr, city: @customer.city, class: @customer.class, county: @customer.county, credit_card: @customer.credit_card, credit_card_type_id: @customer.credit_card_type_id, customer_id: @customer.customer_id, email: @customer.email, first_name: @customer.first_name, last_name: @customer.last_name, password: @customer.password, phone: @customer.phone, room: @customer.room, shipping_address: @customer.shipping_address, shipping_city: @customer.shipping_city, shipping_country: @customer.shipping_country, shipping_postal_code: @customer.shipping_postal_code, shipping_region: @customer.shipping_region } }
    assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
