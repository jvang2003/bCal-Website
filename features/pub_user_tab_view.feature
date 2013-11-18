Feature: public user can view a calendar as tabular data
	As a 'Public User'
	I want to be able to view a calender as tabular data (table of events)
	So that I can view the events in a compact manner

Background: calendars have been added to the app
	Given I have authenticated "real google calendar" from "bCalWebsiteTesting@gmail.com" with the code "code=4/PnHji7a-qODG2hDq_uJgn-mV6ngl.gnzr9tb_UXUZMqTmHjyTFGPm-ZrRhAI"
    And I am viewing the calendar "real google calendar"

Scenario: when I viewing a calendar, I should see it in its tabular view. 
	Then I should see the calendar in tabular form
	
	# 'real google calendar' already has already been created and has existing events
    # In my scenario, I check for those events even though I did not add them through this script
	And I should see the event "Pastor Ed's Birthday" on "November 10"
	And I should see the event "CS169 Team Dinner" on "November 11"