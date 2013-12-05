Given /the following calendars exist/ do |calendars_table|
    calendars_table.hashes.each do |calendar|
        Calendar.create!(calendar)
    end
end

Given /I am on the homepage/ do
    visit("/")
end

When /I try to create a calendar "(.*)"/ do |calendar| #done
    click_link "calendar_create"
end

When /I fill in the form for calendar with the following: (.*)/ do |calendar| #done
    attributes = calendar.split %r{,\s*}
    fill_in :calendar_name, :with => attributes[0]
    fill_in :calendar_email, :with => attributes[1]
    select "Public", :from => :calendar_visibility
    check("Fee required") unless attributes[3] == "no"
    check("Disabled") unless attributes[4] == "no"
    click_button "Create Calendar"
end

When /I try to read a calendar "(.*)"/ do |calendar|
    click_link calendar
end

When /I try to update a calendar "(.*)"/ do |calendar|
    find_by_id("update_" + Calendar.find_by_name(calendar).id.to_s).click
end

When /I change the values for calendar "(.*)" with the following: (.*)/ do |calendar, details| #done
    page.should have_content("Update #{calendar}")

    cal = Calendar.find_by_name(calendar)
    attributes = details.split(%r{,\s*})
    fill_in(:calendar_email, :with => attributes[0])
    select(attributes[1], :from => "calendar_visibility")
    if attributes[2] == "no"
      uncheck "Fee required"
    else
      check "Fee required"
    end
    click_button("Update Calendar")
end

Then /I should see the calendar "(.*?)" in the department admin page/ do |calendar|
  visit calendars_path
  if page.respond_to? :should
    page.should have_content(calendar)
  else
    assert page.has_content?(calendar)
  end
end


Then /I should see the calendar "(.*?)" with the values for the following: (.*)$/ do |calendar, details|
  visit calendars_path

  attributes = details.split(%r{,\s*})
  non_check_box_attr = attributes.slice(0, 3)
  check_box_attr = attributes.slice(3, 5)
  non_check_box_attr.each do |attribute|
   if page.respond_to? :should
     page.should have_content(attribute)
   else
    assert page.has_content?(attribute)
   end
  end

  cal_row = find_row calendar
  header_row = page.find('thead > tr')

  check_box_attr.each do |attribute| #for each check_box attributes, check if the check box are checked accordingly
    attr_pos = -1
    index = 0

    header_row.all('th').each do |item|
      title_attr = attribute.split('_')
      title_attr.pop # I love hacks. Tried slicing, it didn't work
      title_attr = title_attr.map { |e| e.capitalize }.join(' ')
      if item.text == title_attr
        attr_pos = index
      end
      index += 1
    end
    attr_pos.should > 0

    subbed = attribute[attribute.rindex('_')+1..-1]
    cal_row.to_a[attr_pos].text.should == (subbed == "checked" ? "Yes" : "No")
  end
end

Then /the form filled for calendar "(.*)"/ do |calendar|
  cal = Calendar.find_by_name(calendar)
  if page.respond_to? :should
    page.should have_content(cal.name)
  else
    assert page.has_content?(cal.name)
  end
end

When /I (?:delete|destroy|remove) calendar "([^\"]*)"$/ do |calendar_name|
  click_link "DELETE CALENDAR"
end

Then /I should not see calendar "(.*?)"/ do |calendar_name|
  save_and_open_page
  if page.respond_to? :should
    page.should have_no_content(calendar_name)
  else
    assert page.has_no_content?(calendar_name)
  end
end
