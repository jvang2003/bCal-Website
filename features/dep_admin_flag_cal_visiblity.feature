Feature: department admin can flag calendars as public or private

	As a 'Dept Admin'
	I want to be able to flag a calendar as public or private
	So that I can choose which ones are visible to the public (internal use vs external use) or ('Staff User' vs 'Public')

Background: calendars have been added

	Given the following calendars exist:
	| calendar | api-key | privacy | fee-required |
	| Room 1   | 1964    | public  | false        |
	| Room 2   | 2000    | public  | false        |

	Given I am logged in as a department admin

Scenario: make the first calendar private
	When I try to update a calendar "Room 1"
	When I make the visibility of the calendar private
	Then the visibility of calendar "Room 1" should be private
