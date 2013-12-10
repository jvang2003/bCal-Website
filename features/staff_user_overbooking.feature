Feature: Staff user should be able to see all the overbookings in his/her calendar

Background:Given I am logged in as a staff user
	   Given the following requests exist:
	| place_id | people  | reason                 | status   | start_time  |
	| 1        | 4       | We're having a partay  | Pending  | 10:00       |
	| 1        | 42      | Office hours           | Pending  | 10:00       |
	| 3        | 5       | Serious business       | Rejected | 11:00       |

Scenario: Given I am on the overbooking page
	I should be able to see We're having a partay and Office hours

