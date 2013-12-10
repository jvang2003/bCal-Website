Feature: Any changes a user makes in our app will show up in Google Calendar

	As any user that can CRUD an event
	I should be able to CRUD events in the app that are reflected on the Google Calendar
	So that I the Google Calendar can be easily maintained

Background: calendars have been added

	Given the following calendars exist:
	| name | email 				          |
	| Test | bCalWebsiteTesting@gmail.com |

	Given the following requests exist:
	| reason                 | status   | details        | start_time  	    | finish_time         |
	| We're having a partay  | approved | fofofofofofofo | 2013-11-10 12:22:26  | 2013-11-10 19:22:26 |

	Given I am logged in as public user "1"
	And I am on the homepage
	And I authenticate the calendar "Test" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: a created event should show up on my google calendar
	When I create an event with request "1" and a calendar id "1"
	Then I should see the event with id "1" in my google calendar
