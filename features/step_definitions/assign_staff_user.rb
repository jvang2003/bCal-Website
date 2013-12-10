Given(/^I am on the edit calendar page for "(.*?)"$/) do |cal_name|
    visit calendars_path
    click_link "update_#{Calendar.find_by_name(cal_name).id.to_s}"
end

Given(/^I have assigned "(.*?)" to real google cal$/) do |owner|
    user_id = User.find_by_name(owner).id
    find("option[value='#{user_id.to_s}']").click
    click_button "Update Calendar"
end

Then(/^the owner of "(.*?)" should be "(.*?)"$/) do |cal_name, owner_name|
    click_link cal_name
    page.should have_content(owner_name)
end