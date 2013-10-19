Feature: department admin can disable calendars

	As a 'Dept Admin'
	I want to disable a calendar
	So that I can prevent it's use without deleting it from the system.

Background: calendars have been added  

	Given the following calendars exist:
	| calendar | api-key     | privacy |
	| Room 1   | 13123213213 | public  |
	| Room 2   | 12313123123 | public  |

Scenario: disable the first calendar
	When I disable calendar for "Room 1"
	I should not be able to add an event to "Room 1"
	But I should be able to add an event to "Room 2"