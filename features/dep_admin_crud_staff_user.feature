Feature: Dept Admin should be able to CRUD 'Staff Users'

    As a 'Dept Admin'
    I want to CRUD 'Staff Users'
    So that I can manage staff authorizations.

Background: users have been added to the database
    Given the following users exist:
    |calnet_id    | role              | name     | email                    |
    |bob          | App Admin         | Bob      | DontEmailMe1@noemail.com |
    |bill         | Dept Admin        | Bill     | DontEmailMe2@noemail.com |
    |alice        | Admin             | Alice    | DontEmailMe3@noemail.com |

    And I am logged in as a "Dept Admin"
    And I am on the homepage

Scenario: Able to add new staff user
    When I create a user with calnet "mallory" name "Mallory Ohallary" role "0"
    Then I should see "mallory" in the list of users

Scenario: Not able to create an app admin
    Given I am logged in as a "Dept Admin"
    Then I should not see "App Admin" in the list of roles

Scenario: Able to delete Staff User
    Given I am logged in as a "Dept Admin"
    Then I should see "alice" in the list of users
    When I try to delete user "alice"
    Then I should not see "alice" in the list of users

Scenario: Not able to delete App Admin
    Given I am logged in as a "Dept Admin"
    Then I should see "bob" in the list of users
    When I try to delete user "bob"
    Then I should see "bob" in the list of users

Scenario: Able to edit Staff User
    When I try to edit the user named "alice"
    And  I try to change their calnet_id to "alicia"
    Then I should see "alicia" in the list of users
    And I should not see "alice" in the list of users

Scenario: Not able to edit App Admin
    When I try to edit the user named "bob"
    Then I should not see "bobb" in the list of users

