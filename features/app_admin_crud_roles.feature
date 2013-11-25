Feature: App admin can CRUD users to roles

	As an 'App Admin'
    I want to CRUD users to authorization roles 
    So that authorizations are easy to manage.

Background: roles have been added to the database
    Given the following roles exist:
    |calnet_id    | role              | name     |
    |bob          | dept_admin        | whatever |
    |alice        | staff             | whatever |
  
    And I am logged in as an app admin
    And I am on the homepage
    
Scenario: able to add new user
    When I try to add a new user
    And I fill in "mallory"
    Then I should see "mallory" in the list of roles
    
Scenario: able to delete user
    When I try to delete user "bob"
    Then I should not see "bob" in the list of roles

Scenario: able to edit user
    When I try to change "alice" to "dept_admin"
    Then I should see "alice" with role "dept_admin" 

