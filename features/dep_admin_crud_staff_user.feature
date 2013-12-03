Feature: Dept Admin should be able to CRUD 'Staff Users'

    As a 'Dept Admin'
    I want to CRUD 'Staff Users'
    So that I can manage staff authorizations.

Background: users have been added to the database
    Given the following users exist:
    |calnet_id    | role              | name     |
    |bob          | App Admin         | whatever |
    |bill         | Dept Admin        | whatever |

    And I am logged in as a "Dept Admin"
    And I am on the homepage

Scenario: able to add new staff user
    When I create a user with calnet "mallory" name "Mallory Ohallary" role "0"
    Then I should see "mallory" in the list of users

Scenario: able to delete staff user
    When I view the users
    Then I should see "bob" in the list of users
    When I try to delete user "bob"
    Then I should not see "bob" in the list of users

Scenario: able to edit staff user
    When I try to change calnet_id of "alice" to "alicia"
    And I view the users
    Then I should see "alicia" in the list of users
    And I should not see "alice" in the list of users

Scenario: Not able to create an app admin
    Then I should not see "App Admin" in the list of roles
