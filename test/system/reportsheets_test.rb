require "application_system_test_case"

class ReportsheetsTest < ApplicationSystemTestCase
  setup do
    @reportsheet = reportsheets(:one)
  end

  test "visiting the index" do
    visit reportsheets_url
    assert_selector "h1", text: "Reportsheets"
  end

  test "creating a Reportsheet" do
    visit reportsheets_url
    click_on "New Reportsheet"

    fill_in "Comment", with: @reportsheet.comment
    fill_in "User", with: @reportsheet.user_id
    click_on "Create Reportsheet"

    assert_text "Reportsheet was successfully created"
    click_on "Back"
  end

  test "updating a Reportsheet" do
    visit reportsheets_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @reportsheet.comment
    fill_in "User", with: @reportsheet.user_id
    click_on "Update Reportsheet"

    assert_text "Reportsheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Reportsheet" do
    visit reportsheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reportsheet was successfully destroyed"
  end
end
