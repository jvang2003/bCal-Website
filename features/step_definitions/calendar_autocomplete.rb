Then /I should be able to see autocomplete in the field for place for all calendars$/ do
    page.should have_content("calendar1")
    page.should have_content("calendar2")
end
