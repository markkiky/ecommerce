require 'test_helper'

class ShippingAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_address = shipping_addresses(:one)
  end

  test "should get index" do
    get shipping_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_address_url
    assert_response :success
  end

  test "should create shipping_address" do
    assert_difference('ShippingAddress.count') do
      post shipping_addresses_url, params: { shipping_address: { address: @shipping_address.address, city: @shipping_address.city, country: @shipping_address.country, postal_code: @shipping_address.postal_code, region: @shipping_address.region } }
    end

    assert_redirected_to shipping_address_url(ShippingAddress.last)
  end

  test "should show shipping_address" do
    get shipping_address_url(@shipping_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_address_url(@shipping_address)
    assert_response :success
  end

  test "should update shipping_address" do
    patch shipping_address_url(@shipping_address), params: { shipping_address: { address: @shipping_address.address, city: @shipping_address.city, country: @shipping_address.country, postal_code: @shipping_address.postal_code, region: @shipping_address.region } }
    assert_redirected_to shipping_address_url(@shipping_address)
  end

  test "should destroy shipping_address" do
    assert_difference('ShippingAddress.count', -1) do
      delete shipping_address_url(@shipping_address)
    end

    assert_redirected_to shipping_addresses_url
  end
end
