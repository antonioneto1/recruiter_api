require "application_system_test_case"

class RecruitersTest < ApplicationSystemTestCase
  setup do
    @recruiter = recruiters(:one)
  end

  test "visiting the index" do
    visit recruiters_url
    assert_selector "h1", text: "Recruiters"
  end

  test "creating a Recruiter" do
    visit recruiters_url
    click_on "New Recruiter"

    fill_in "Email", with: @recruiter.email
    fill_in "Name", with: @recruiter.name
    fill_in "Password", with: @recruiter.password
    click_on "Create Recruiter"

    assert_text "Recruiter was successfully created"
    click_on "Back"
  end

  test "updating a Recruiter" do
    visit recruiters_url
    click_on "Edit", match: :first

    fill_in "Email", with: @recruiter.email
    fill_in "Name", with: @recruiter.name
    fill_in "Password", with: @recruiter.password
    click_on "Update Recruiter"

    assert_text "Recruiter was successfully updated"
    click_on "Back"
  end

  test "destroying a Recruiter" do
    visit recruiters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recruiter was successfully destroyed"
  end
end
