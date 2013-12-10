Feature: Any changes a user makes in our app will show up in Google Calendar

	As any user that can CRUD an event
	I should be able to CRUD events in the app that are reflected on the Google Calendar
	So that I the Google Calendar can be easily maintained

Background: calendars have been added
	Given the following users exist:
	| calnet_id | email         | name | role      |
	| test      | t@example.com | Test | App Admin |

	Given the following calendars exist:
	| name   | email 				        |
	| Room 1 | bCalWebsiteTesting@gmail.com |

	Given the following requests exist:
	| place    | people  | reason                 | status   | user    |
	| Room 1   | 4       | We're having a partay  | Pending  |  test   |

	And I am on the homepage
	And I am logged in as "test"
	And I authenticate the calendar "Room 1" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: a created event should show up on my google calendar
	When I create an event with request "1" and a calendar id "Room 1"
	And I approve a request for "Room 1"
	Then I should see the event with id "1" in my google calendar
