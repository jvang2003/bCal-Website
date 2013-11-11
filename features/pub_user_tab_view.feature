Feature: public user can view a calendar as tabular data
	As a 'Public User'
	I want to be able to view a calender as tabular data
	So that I can view the events in a compact manner

Background: calendars have been added to the app
	Given the following calendars exist:
    |name           |key |visib  | fee_required |disabled|
    |testing        |323 |public | false        |true    |

    And I am viewing the calendar "testing"

Scenario: when I click on tabular view, it switches to tabular view
	# for now there is only tabular view but we are anticipating another
	# option to view calendars so that's why there's a button to switch
	# to tabular view
	When I switch to tabular view
	Then I should see the calendar in tabular form