Feature: App admin can CRUD users to roles

	As an 'App Admin'
    I want to CRUD users to authorization roles
    So that authorizations are easy to manage.

Background: roles have been added to the database
    Given the following users exist:
    |calnet_id    | role              | name     |
    |bob          | App Admin         | whatever |
    |alice        | Admin             | whatever |

    And I am logged in as an "App Admin"
    And I am on the homepage

Scenario: able to add new user
    When I try to add a new user
    And I fill in "mallory"
    Then I should see "mallory" in the list of roles

Scenario: able to delete user
    When I view the users
    And I try to delete user "bob"
    Then I should not see "bob" in the list of roles

Scenario: able to edit user
    When I try to change calnet_id of "alice" to "alicia"
    And I view the users
    Then I should see "alicia" in the list of roles
    And I should not see "alice" in the list of roles


