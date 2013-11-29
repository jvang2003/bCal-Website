Feature: Staff users should be able to export a calendar to a CSV file. 
	As a 'Staff User'
	I want to be able to export my calendar as a csv of events
	So I that I can print or save my own reports offline.

Background: a calendar with events has been added and authorized
    Given I am logged in as staff user "user1"
    Given the following calendars exist:
   	| name            |     email                    | visib   | fee_required |disabled|
	| real google cal | bCalWebsiteTesting@gmail.com | public  | false        |true    |	 
 
 	# hacky way of authentication
	And I authenticate the calendar "real google cal" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: when I am viewing a calendar, I can choose to export it to CSV
	When I am viewing calendar "real google cal"
	And I export it to csv
	Then I should see in the CSV the event "Pastor Ed's Birthday"
	And I should see in the csv the event "CS169 Team Dinner"