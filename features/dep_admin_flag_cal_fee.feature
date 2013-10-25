Feature: department admin can flag calendar fees_required

	As a 'Dept Admin'
	I want to flag a calendar if it requires a fee 
	So that when 'Public Users' make reservations, they can have a note that a fee may be required to reserve this space (just an alert, but they can still reserve it)

Background: calendars have been added

	Given the following calendars exist:
	| calendar | api-key     | privacy | fee-required |
	| Room 1   | 13123213213 | public  | false        |
	| Room 2   | 12313123123 | public  | false        | 

	Given I am logged in as a department admin

Scenario: change the first calendar to require a fee
	When I try to update a calendar "Room 1"
	When I make the calendar fees required
	Then the calendar "Room 1" should require a fee