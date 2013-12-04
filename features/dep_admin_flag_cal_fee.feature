Feature: department admin can flag calendar fees_required

	As a 'Dept Admin'
	I want to flag a calendar if it requires a fee
	So that when 'Public Users' make reservations, they can have a note that a fee may be required to reserve this space (just an alert, but they can still reserve it)

Background: calendars have been added

	Given the following calendars exist:
	| name     |     email     | visibility   | fee_required |disabled|
	| Room1    | 13123213213   | public       | false        |true    |
	| Room2    | 12313123123   | public       | false        |false   |

	Given I am logged in as a department admin
        And I am on the homepage

Scenario: change the first calendar to require a fee
	When I try to update a calendar "Room1"
	When I make the calendar fees required
	Then the calendar "Room1" should require a fee
