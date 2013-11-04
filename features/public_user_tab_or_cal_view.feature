Feature: public user can switch between calendar and tabular view
	As a 'Public User'
	I want to be able to view a calender as a calendar or tabular data
	So that I can pick the one I'm most comfortable with.

Background: calendars have been added to the app
	Given the following calendars exist:
    |name           |key |visib  | fee_required |disabled|
    |testing        |323 |pbulic | false        |true    |

    And I am on the edit page for "testing"

Scenario: when I view a calendar, it is automatically in calendar view
	Then I should see the embedded calendar

Scenario: when I click on tabular view, it switches to tabular view
	When I switch to tabular view
	Then I should see the calendar in tabular form

Scenario: when I click on calendar view while in tabular view, it switches to calendar view
	When I switch to calendar view
	And I switch to tabular view
	Then I should see the calendar in tabular form