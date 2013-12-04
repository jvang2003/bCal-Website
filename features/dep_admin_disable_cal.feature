Feature: department admin can disable calendars

	As a 'Dept Admin'
	I want to disable a calendar
	So that I can prevent it's use without deleting it from the system.

Background: calendars have been added to the database
	Given the following calendars exist:
	| name     | email         | visibility   | fee_required | disabled |
	| Room 1   | 13123213213   | Public       | false        | false    |
	| Room 2   | 12313123123   | Public       | false        | false    |

	Given I am logged in as a department admin
	And I am on the homepage

Scenario: department admin disable the first calendar
	When I try to update a calendar "Room 1"
	And I disable the calendar
	Then calendar "Room 1" should be disabled
	But calendar "Room 2" should not be disabled
