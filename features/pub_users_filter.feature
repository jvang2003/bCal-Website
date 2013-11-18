Feature: Pubilc user can select a calendar by its attributes

	As a 'Public User'
	I want to be able to select a calendar by building, usage, time, dept
	so that I can have options in my reservations

Background: calendars have been added to the database

	Given the following calendars exist:
	|name           |key |visib  | fee_required |disabled |building  |usage        |dept     |
    |calendar1      |123 |public | true         |true     |Cory      |department  |Civil E  |
    |calendar2      |345 |public | false        |false    |Soda      |personal    |EECS     |
    |calendar3      |678 |public | false        |false    |Soda      |personal    |Civil E  |

    #And I am logged in as a public user

Scenario: able to filter calendars by building
	When I try to search by building with "Cory"
	Then I should see calendar "calendar1"
	Then I should not see calendar "calendar2"
	Then I should not see calendar "calendar3"

Scenario: able to filter calendars by usage
	When I try to search by usage with "personal"
	Then I should not see calendar "calendar1"
	Then I should see calendar "calendar2"
	Then I should see calendar "calendar3"

Scenario: able to search calendars by dept
	When I try to search by dept with "Civil E"
	Then I should see calendar "calendar1"
	Then I should not see calendar "calendar2"
	Then I should see calendar "calendar3"




