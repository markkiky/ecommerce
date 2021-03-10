require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get requests_url
    assert_response :success
  end

  test "should get new" do
    get new_request_url
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post requests_url, params: { request: { request_email: @request.request_email, request_first_name: @request.request_first_name, request_last_name: @request.request_last_name, request_message: @request.request_message, request_phone_number: @request.request_phone_number, request_subject: @request.request_subject } }
    end

    assert_redirected_to request_url(Request.last)
  end

  test "should show request" do
    get request_url(@request)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_url(@request)
    assert_response :success
  end

  test "should update request" do
    patch request_url(@request), params: { request: { request_email: @request.request_email, request_first_name: @request.request_first_name, request_last_name: @request.request_last_name, request_message: @request.request_message, request_phone_number: @request.request_phone_number, request_subject: @request.request_subject } }
    assert_redirected_to request_url(@request)
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete request_url(@request)
    end

    assert_redirected_to requests_url
  end
end
