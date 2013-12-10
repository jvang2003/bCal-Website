Feature: Staff user should be able to see all the overbookings in his/her calendar

Background:Given I am logged in as a staff user
	   Given the following requests exist:
	| place    | people  | reason                 | status   | start_time  |
	| Room 1   | 4       | We're having a partay  | Pending  | 10:00       |
	| Room 1   | 42      | Office hours           | Pending  | 10:00       |
	| Room 3   | 5       | Serious business       | Rejected | 11:00       |

Scenario: Given I am on the overbooking page
	I should be able to see We're having a partay and Office hours

