Feature: Users should have an easy way to pick which calendar to add a request to
    As a 'Public User'
    I want to pick the place for my event easily and correctly
    So that I can reserve a room in the correct calendar.


Background: calendars have been added to the database
    Given the following calendars exist:
    |name           |email | visibility  | fee_required |disabled |
    |calendar1      |123   | public      | true         |true     |
    |calendar2      |345   | private     | false        |false    |

    And I am logged in as public user "public_user"
    And I am on the homepage

Scenario: able to have autocomplete
    When I try to submit a request for reserving a room
    Then I should be able to see autocomplete in the field for place for all calendars

