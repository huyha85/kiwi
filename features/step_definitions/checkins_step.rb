Given(/^I have a user with (\d+) checkins$/) do |num_checkins|
  @user = create(:user)
  @user_checkins = create_list(:checkin, num_checkins.to_i, user_id: @user.id.to_s)
end

Given(/^I have (\d+) checkins$/) do |num_checkins|
  @checkins = create_list(:checkin, num_checkins.to_i)
end

When(/^I go to checkins page$/) do
  visit checkins_path
end

When(/^I select the user email from dropdown$/) do
  select @user.email, from: 'users'
end

When(/^I click on '(.*)'$/) do |link|
  click_on link
end

Then(/^I should see (\d+) checkins$/) do |num_checkins|
  expect(page).to have_css("table#checkin-details tbody tr", count: num_checkins)
end