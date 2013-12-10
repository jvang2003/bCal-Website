Feature: App admin can CRUD users to roles

	As an 'App Admin'
    I want to CRUD users to authorization roles
    So that authorizations are easy to manage.

Background: roles have been added to the database
    Given the following users exist:
    |calnet_id    | role              | name  | email                    |
    |bob          | App Admin         | bob   | DontEmailMe1@noemail.com |
    |alice        | Admin             | alice | DontEmailMe1@noemai2.com |

    And I am logged in as an "App Admin"
    When I view the users

Scenario: able to add new user
    When I try to add a new user with username "mallory"
    Then I should see "mallory" in the list of users

Scenario: able to delete user
    When I try to delete user "bob"
    Then I should not see "bob" in the list of users

Scenario: able to edit user
    When I try to change the name of "alice" to "Alicia"
    And I view the users
    Then I should see "Alicia" in the list of users
    And I should not see "alice" in the list of users


