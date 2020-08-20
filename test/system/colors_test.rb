require "application_system_test_case"

class ColorsTest < ApplicationSystemTestCase
  setup do
    @color = colors(:one)
  end

  test "visiting the index" do
    visit colors_url
    assert_selector "h1", text: "Colors"
  end

  test "creating a Color" do
    visit colors_url
    click_on "New Color"

    fill_in "Color type", with: @color.color_type
    click_on "Create Color"

    assert_text "Color was successfully created"
    click_on "Back"
  end

  test "updating a Color" do
    visit colors_url
    click_on "Edit", match: :first

    fill_in "Color type", with: @color.color_type
    click_on "Update Color"

    assert_text "Color was successfully updated"
    click_on "Back"
  end

  test "destroying a Color" do
    visit colors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Color was successfully destroyed"
  end
end
