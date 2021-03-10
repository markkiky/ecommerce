require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  setup do
    @request = requests(:one)
  end

  test "visiting the index" do
    visit requests_url
    assert_selector "h1", text: "Requests"
  end

  test "creating a Request" do
    visit requests_url
    click_on "New Request"

    fill_in "Request email", with: @request.request_email
    fill_in "Request first name", with: @request.request_first_name
    fill_in "Request last name", with: @request.request_last_name
    fill_in "Request message", with: @request.request_message
    fill_in "Request phone number", with: @request.request_phone_number
    fill_in "Request subject", with: @request.request_subject
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "updating a Request" do
    visit requests_url
    click_on "Edit", match: :first

    fill_in "Request email", with: @request.request_email
    fill_in "Request first name", with: @request.request_first_name
    fill_in "Request last name", with: @request.request_last_name
    fill_in "Request message", with: @request.request_message
    fill_in "Request phone number", with: @request.request_phone_number
    fill_in "Request subject", with: @request.request_subject
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "destroying a Request" do
    visit requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request was successfully destroyed"
  end
end
