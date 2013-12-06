Feature: Staff users should be able to export views to CSV.
	As a 'Staff User'
	I want to be able to export my views to CSV
	So I that I can print or save my own reports offline.

Background: two calendars with events has been added and authorized
    Given I am logged in as staff user "user1"
    Given the following calendars exist:
   	| name            |     email                    | visibility   | fee_required | disabled|
	| real google cal | bCalWebsiteTesting@gmail.com | public       | false        | true    |
	| second calendar | not-real-calendar@bmail.com  | private      | true         | false   |

	And I authenticate the calendar "real google cal" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"
	# don't have to authorize second calender because will only view real google cal

Scenario: I can choose to export the index of calendars to CSV
	When I am on the index page
	And I export it to CSV
	Then I should see in the CSV the events: real google cal, second calendar

Scenario: I can choose to export an individual calendar to CSV
	When I am viewing calendar "real google cal"
	And I export it to CSV
	Then I should see in the CSV the calendars: Pastor Ed's Birthday, CS169 Team Dinner