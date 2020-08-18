require "application_system_test_case"

class SizesTest < ApplicationSystemTestCase
  setup do
    @size = sizes(:one)
  end

  test "visiting the index" do
    visit sizes_url
    assert_selector "h1", text: "Sizes"
  end

  test "creating a Size" do
    visit sizes_url
    click_on "New Size"

    fill_in "Size type", with: @size.size_type
    click_on "Create Size"

    assert_text "Size was successfully created"
    click_on "Back"
  end

  test "updating a Size" do
    visit sizes_url
    click_on "Edit", match: :first

    fill_in "Size type", with: @size.size_type
    click_on "Update Size"

    assert_text "Size was successfully updated"
    click_on "Back"
  end

  test "destroying a Size" do
    visit sizes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Size was successfully destroyed"
  end
end
