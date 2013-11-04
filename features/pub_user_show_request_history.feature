Feature: Any user can show the history of all event requests they made

	As a 'Public User'
	I want to be able to see my reservations and status 
	So that I can track my reservation history.

Background: calendars have been added

	Given the following requests exist:
	| room     | user_id | calendar_id | num_ppl | reason                 | can_chg_room | status   |
	| Room 1   | 1       | 1           | 4       | We're having a partay  | false        | approved |
	| Room 2   | 1       | 1           | 42      | Office hours           | true         | pending  |
	| Room 3   | 1       | 1           | 5       | Serious business       | false        | rejected |
	| Room 4   | 2       | 1           | 2       | No reason whatsoever   | true         | approved |

	Given I am logged in as public user 1
	And I am on the homepage

Scenario: show all history
	When I view my request history
	I should see room "Room 1" with status "Approved"
	I should see room "Room 2" with status "Pending"
	I should see room "Room 3" with status "Rejected"
	I should not see room "Room 4"

Scenario: show approved
	When I view my request history
	And I filter by Approved
	I should see room "Room 1" with status "Approved"
	I should not see room "Room 2"
	I should not see room "Room 3"
	I should not see room "Room 4"

Scenario: show pending
	When I view my request history
	And I filter by Pending
	I should see room "Room 2" with status "Pending"
	I should not see room "Room 1"
	I should not see room "Room 3"
	I should not see room "Room 4"

Scenario: show rejected 
	When I view my request history
	And I filter by Rejected
	I should see room "Room 3" with status "Rejected"
	I should not see room "Room 1"
	I should not see room "Room 2"
	I should not see room "Room 4"
