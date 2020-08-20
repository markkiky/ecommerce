require 'test_helper'

class SizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @size = sizes(:one)
  end

  test "should get index" do
    get sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_size_url
    assert_response :success
  end

  test "should create size" do
    assert_difference('Size.count') do
      post sizes_url, params: { size: { size_type: @size.size_type } }
    end

    assert_redirected_to size_url(Size.last)
  end

  test "should show size" do
    get size_url(@size)
    assert_response :success
  end

  test "should get edit" do
    get edit_size_url(@size)
    assert_response :success
  end

  test "should update size" do
    patch size_url(@size), params: { size: { size_type: @size.size_type } }
    assert_redirected_to size_url(@size)
  end

  test "should destroy size" do
    assert_difference('Size.count', -1) do
      delete size_url(@size)
    end

    assert_redirected_to sizes_url
  end
end
