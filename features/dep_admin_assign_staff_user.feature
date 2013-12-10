Feature: Department Admin should be able to CRUD staff users to calendars.

Background: Given I am logged in as a Dept admin
    Given the following users exist:
    | name            |  role      | calnet_id    | email             |
    | Ben             |  staff     | benner       | ben@example.com   |
    | Rick            |  staff     | ricky        | rick@example.com  |
    | Admin           |  App Admin | admin        | admin@example.com |

    Given the following calendars exist:
    | name            |     email                    | visibility   | fee_required |disabled|
    | real google cal | bCalWebsiteTesting@gmail.com | public       | false        |true    |

    And I authenticate the calendar "real google cal" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: Assigning owner works
    Given I am logged in as an "App Admin"
    Given I am on the edit calendar page for "real google cal"
    And I have assigned "Ben" to real google cal
    Then the owner of "real google cal" should be "Ben"

