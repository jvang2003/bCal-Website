Feature: Staff User should be able to view/edit/approve/deny any reservations
    As a 'Staff User'
    I want to be able to view/edit/approve/deny any reservations
    So that I have final say over what happens on a calendar.

Background: requests have been added
    Given I am logged in as staff user "user1"

	Given the following requests exist:
	| place    | people  | reason                 | status   |
	| Room 1   | 4       | We're having a partay  | Pending  |
	| Room 2   | 42      | Office hours           | Pending  |
	| Room 3   | 5       | Serious business       | Pending  |

    Given the following calendars exist:
    |name           |email |visib  | fee_required |disabled|
    |Room 1         |123   |public | true         |true    |
    |calendar2      |345   |private| false        |false   |

	And I am on the homepage

Scenario: view all requests
        When I view all the requests
        Then I should see all the requests

Scenario: approve requests
        When I approve a request for "Room 1"
        Then I should see the request approved for "Room 1"

Scenario: deny requests
        When I deny a request for "Room 1"
        Then I should see the request denied for "Room 1"

Scenario: edit requests
        When I edit a request for "Room 1" assuming it was accepted previously
        Then I should see the request edited for "Room 1"
