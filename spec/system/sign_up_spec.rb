require 'rails_helper'

RSpec.describe "User signs up", type: :system do
  before do
    visit new_user_registration_path
  end

  it "creates a user with valid parameters" do
    fill_in "Email", with: 'test@example.com'
    fill_in "Name", with: 'test'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button 'Sign up'

    # user = User.last
    # visit user_path(user)
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  it "is invalid with duplicated email address" do
    user = FactoryBot.create(:user)

    fill_in "Email", with: user.email
    fill_in "Name", with: "test2"
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button 'Sign up'

    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Email has already been taken"
  end

  it "is invalid with duplicated name" do
    user = FactoryBot.create(:user)

    fill_in "Email", with: "test@example.com"
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button 'Sign up'

    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Name has already been taken"
  end
end
