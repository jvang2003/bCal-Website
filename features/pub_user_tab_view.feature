Feature: public user can view a calendar as tabular data
	As a 'Public User'
	I want to be able to view a calender as tabular data (table of events)
	So that I can view the events in a compact manner

Background: a calendar have been added to the app
	Given that the following calendars exist:
	| name            |     email                    | visib   | fee_required |disabled|
	| real google cal | bCalWebsiteTesting@gmail.com | public  | false        |true    |	 
    
    # hacky way of authentication
	And I authenticate the calendar "real google cal" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: when I viewing a calendar, I should see it in its tabular view.
	And I am viewing the calendar "real google cal"
	Then I should see the calendar in tabular form
	
	# 'real google calendar' already has already been created and has existing events
    # In my scenario, I check for those events even though I did not add them through this script
	And I should see the event "Pastor Ed's Birthday"
	And I should see the event "CS169 Team Dinner"