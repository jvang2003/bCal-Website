Feature: Any changes a user makes in our app will show up in Google Calendar

	As any user that can CRUD an event
	I should be able to CRUD events in the app that are reflected on the Google Calendar
	So that I the Google Calendar can be easily maintained

Background: calendars have been added

	Given the following calendars exist:
	| name | fee_required | key | visib  | disabled |
	| Test | false        | 123 | public | true     | 

	Given the following requests exist:
	| room     | user_id | calendar_id | num_ppl | reason                 | can_chg_room | status   |
	| Room 1   | 1       | 1           | 4       | We're having a partay  | false        | approved |

	Given I am logged in as public user "1"
	And I am on the homepage
	And the Google Calendar API is initialized

Scenario: a created event should show up on my google calendar
	When I create an event with request "1" and google calendar id "11"
	Then I should see the event with title "Test" in my google calendar
