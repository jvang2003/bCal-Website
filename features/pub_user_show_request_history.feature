Feature: Any user can show the history of all event requests they made

	As a 'Public User'
	I want to be able to see my reservations and status 
	So that I can track my reservation history.

Background: requests have been added

	Given the following requests exist:
	| place    | people  | reason                 | status   |
	| Room 1   | 4       | We're having a partay  | Approved |
	| Room 2   | 42      | Office hours           | Pending  |
	| Room 3   | 5       | Serious business       | Rejected |

	And I am on the homepage

Scenario: show all history
	When I view my request history
	Then I should see room "Room 1" with status "Approved"
	And I should see room "Room 2" with status "Pending"
	And I should see room "Room 3" with status "Rejected"

Scenario: show approved
	When I view my request history
	And I filter by Approved
	Then I should see room "Room 1" with status "Approved"

Scenario: show pending
	When I view my request history
	And I filter by Pending
	Then I should see room "Room 2" with status "Pending"

Scenario: show rejected 
	When I view my request history
	And I filter by Rejected
	Then I should see room "Room 3" with status "Rejected"
