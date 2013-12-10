Feature: Any user can view and filter through the history of requests they have made.

	As a 'Public User'
	I want to be able to filter through my reservations by their status
	So that I can track my reservation history easily.

Background: requests have been added

    Given the following users exist:
    |calnet_id    | role              | name  | email            |
    | bill	      | Guest			  | Billy | bill@example.com |

    And the following calendars exist:
    | name           |email |visibility  | fee_required |disabled|
    | Room 1         |123   |public      | true         |true    |
    | Room 2         |345   |private     | false        |false   |
    | Room 3         |345   |private     | false        |false   |

	And the following requests exist:
	| place    | people  | reason                 | status   | user  |
	| Room 1   | 4       | We're having a partay  | Approved | bill	 |
	| Room 2   | 42      | Office hours           | Pending  | bill  |
	| Room 3   | 5       | Serious business       | Rejected | bill  |

	And I am on the homepage
	And I am logged in as "bill"

Scenario: show all history
	When I view my request history
	Then I should see room "Room 1" with status "Approved"
	And I should see room "Room 2" with status "Pending"
	And I should see room "Room 3" with status "Rejected"

Scenario: show only my approved requests
	When I view my request history
	And I filter by Approved
	Then I should see room "Room 1" with status "Approved"
	And I should not see room "Room 2"
	And I should not see room "Room 3"

Scenario: show only my pending requests
	When I view my request history
	And I filter by Pending
	Then I should see room "Room 2" with status "Pending"
	And I should not see room "Room 3"
	And I should not see room "Room 1"

Scenario: show only my rejected requests
	When I view my request history
	And I filter by Rejected
	Then I should see room "Room 3" with status "Rejected"
	And I should not see room "Room 1"
	And I should not see room "Room 2"
