Given /the following calendars exist$/ do |calendars_table| #done
    calendars_table.hashes.each do |calendar|
        Calendar.create!(calendar)
    end
end

When /I try to create a calendar "(.*)"/ do |calendar| #done
    click_link("Create new calendar") #will visit path_to('/calendars/new')
end

When /I fill in the form for calendar with the following: (.*)/ do |calendar| #done
    attributes = calendar.split(%r{,\s*})
    fill_in(:name,:with => attributes[0] )
    fill_in(:api_key,:with => attributes[1])
    check(attributes[2])
    check(attributes[3]) unless attributes[3] == "no"
    Calendar.create(:name => attributes[0], :api_key => attributes[1], :flag => attributes[2], :fee_required => attributes[3])
    click_button("Create")
end

When /I try to read a calendar "(.*)"/ do |calendar| #done
    click_link(calendar)
end

When /I try to update a calendar "(.*)"/ do |calendar| #done
    click_button("Update #{calendar}")
end

When /I change the values for calendar "(.*)" with the following: (.*)/ do |calendar, details| #done
    cal = Calendar.find(calendar)
    attributes = details.split(%r{,\s*})
    fill_in(:api_key, :with => attributes[0])
    if (attributes[1] == "public")
        uncheck("private")
    else
        uncheck("public")
    end
    check(attributes[1])
    check(attributes[2]) unless attributes[2] == "no"
    cal.save
    click_button("update" + calendar)
end

Then /I should see the calendar "(.*)" in the department_admin page/ do |calendar| #done
  if page.respond_to? :should
    page.should have_content(calendar)
  else
    assert page.has_content?(calendar)
  end
end


Then /I should see the calendar (".*") with the values for the following: (.*)/ do |details|
  attributes = details.split(%r{,\s*})
  non_check_box_attr = details.slice(0, 2)
  check_box_attr = details.slice(2, 2)
  non_check_box_attr.each do |attribute|
    if page.respond_to? :should
      page.should have_content(attribute)
    else
      assert page.has_content?(attribute)
    end
  end
  check_box_attr.each do |attribute| #for each check_box attributes, check if the check box are checked accordingly
    attribute = attribute.gsub("_checked", "") #e.g to change fee_required_checked to fee_required 
    with_scope(calendar) do
      field_checked = find_field(attribute)['checked']
      if field_checked.respond_to? :should
        field_checked.should be_true
      else
        assert field_checked
      end
    end
  end
end

Then /I should see the form filled for calendar "(.*)"/ do |calendar|
  cal = Calendar.find(calendar)
  if page.respond_to? :should
    page.should have_content(cal.name)
  else
    assert page.has_content?(cal.name)
  end
end

When /I (?:delete|destroy|remove) calendar "([^\"]*)"$/ do |calendar_name|
  click_button("delete_" + calendar_name)
end

Then /I should see calendar "([^\"]*)"/ do |calendar_name|
  if page.respond_to? :should
	page.should have_content(calendar_name)
  else
	assert page.has_content?(calendar_name)
  end
end

Then /I should not see calendar "([^\"]*)"/ do |calendar_name|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

