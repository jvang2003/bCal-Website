Feature: department admin can disable calendars

	As a 'Dept Admin'
	I want to disable a calendar
	So that I can prevent it's use without deleting it from the system.

Background: calendars have been added  
	Given the following calendars exist:
	| calendar | api-key     | privacy | fee-required |
	| Room 1   | 13123213213 | public  | false        |
	| Room 2   | 12313123123 | public  | false        |

	Given I am logged in as a department admin
	
Scenario: department admin disable the first calendar
	When I disable calendar for "Room 1"
	Then calendar "Room 1" should be disabled
	But calendar "Room 2" should not be disabled