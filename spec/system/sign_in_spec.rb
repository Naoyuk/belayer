require 'rails_helper'

RSpec.describe "User signs in", type: :system do
  before do
    @post = FactoryBot.create(:post)
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end

  it "is valid with correct creadentials" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to have_text @post.describe
  end

  it "is invalid with incorrect email address" do
    fill_in "Email", with: "aaaa@example.com"
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to have_no_text @post.describe
    expect(page).to have_text "Invalid Email or password."
  end

  it "is invalid with incorrect password" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "aaaaaaaaa"
    click_button "Log in"

    expect(page).to have_no_text @post.describe
    expect(page).to have_text "Invalid Email or password."
  end
end
