Given /the following calendars exist/ do |calendars_table| #done
    calendars_table.hashes.each do |calendar|
        Calendar.create!(calendar)
    end
end

Given /I am on the homepage/ do
    visit("/")
end

When /I try to create a calendar "(.*)"/ do |calendar| #done
    click_link("Create new calendar") #will visit path_to('/calendars/new')
end

When /I fill in the form for calendar with the following: (.*)/ do |calendar| #done
    attributes = calendar.split(%r{,\s*})
    fill_in(:name,:with => attributes[0] )
    fill_in(:key,:with => attributes[1])
    select("Public", :from => "visib")
    check("Fee required?") unless attributes[3] == "no"
    check("Disabled?") unless attributes[4] == "no"
    Calendar.create(:name => attributes[0], :key => attributes[1], :visib => attributes[2], :fee_required => attributes[3], :disabled => attributes[4])
    click_button("Send")
end

When /I try to read a calendar "(.*)"/ do |calendar| #done
    click_link(calendar)
end

When /I try to update a calendar "(.*)"/ do |calendar| #done
<<<<<<< Updated upstream
    find('a', :text => "Update #{calendar}").click
=======
    click_link("Update #{calendar}")
>>>>>>> Stashed changes
end

When /I change the values for calendar "(.*)" with the following: (.*)/ do |calendar, details| #done
    assert page.has_content?("Edit #{calendar}")
    cal = Calendar.find_by_name(calendar)
    attributes = details.split(%r{,\s*})
    fill_in(:key, :with => attributes[0])
    if (attributes[1] == "public")
        select("Private", :from => "visib")
    else
        select("Public", :from => "visib")
    end
    check("Fee required?") unless attributes[2] == "no"
    click_button("Send")
end

Then /I should see the calendar "(.*)" in the department_admin page/ do |calendar| #done
  if page.respond_to? :should
    page.should have_content(calendar)
  else
    assert page.has_content?(calendar)
  end
end


Then /I should see the calendar (".*") with the values for the following: (.*)$/ do |calendar, details|
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
  check_box_attr.each do |attribute| #for each check_box attributes, check if the check box are checked accordingly
    subbed = attribute.gsub("#{attribute}_", "")
    attribute = attribute.gsub("_checked", "")
    cal = Calendar.find_by_name(calendar)
    #print(find(:css, "#{calendar}").value)
    if subbed == "checked"
     cal.#{attribute}.should == true
    else
     cal.attribute.should == false
    end
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
  click_link("Destroy this calendar")
end

Then /I should be seeing the calendar "([^\"]*)" in the department admin page$/ do |calendar_name|
  if page.respond_to? :should
	page.should have_content(calendar_name)
  else
	assert page.has_content?(calendar_name)
  end
end

Then /I should not see calendar "([^\"]*)"/ do |calendar_name|
  if page.respond_to? :should
    page.should have_no_content(calendar_name)
  else
    assert page.has_no_content?(calendar_name)
  end
end

