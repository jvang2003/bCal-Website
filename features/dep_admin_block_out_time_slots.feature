Feature: Department Admin should be able to block out time slots per calendar
	As a 'Dept Admin'
	I want to be able to block out time slots, per calendar
	So that public users can not reserve those time slots

Background: calendars have been added to the database

	Given the following calendars exist:
	|name           |email |visibility  | fee_required |disabled |building  |usage       |department     |
    |calendar1      |123   |public      | true         |true     |Cory      |department  |Civil E        |
    |calendar2      |345   |public      | false        |false    |Soda      |personal    |EECS           |
    |calendar3      |678   |public      | false        |false    |Soda      |personal    |Civil E        |

	Given I am logged in as a department admin
        And I am on the homepage

Scenario: block the first calendar from 10 am to 11 am
	When I try to block "calendar1" on "12/10/2013" from "10:10" to "11:05"
	Then "calendar1" should not be able to be booked from "10:10am" to "11:05am"
