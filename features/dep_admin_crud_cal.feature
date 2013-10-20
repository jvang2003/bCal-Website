Feature: department admin can CRUD calendars

	As a 'Dept Admin'
	I want to CRUD calendars (name, google keys, etc) 
	So that I can manage our calendars.

Background: calendars have been added to the database
    Given the following calendars exist:
    |name           |api-key | flag  | fee_required |
    |calendar1      |123     |public | yes          |
    |calendar2      |345     |private| no           |
  
    And I am on the "department_admin page"
    And I am logged in as a department admin
    
Scenario: able to create calendar
    When I try to create a calendar "calendar3"
    And I fill in the form for calendar with the following: calendar3,789,public,yes
    Then I should see the calendar "calendar3" in the department_admin page

Scenario: able to read calendar
    When I try to read a calendar "calendar2"
    Then I should see the values for calendar "calendar2" with the following: calendar2,123,public,fee_required_checked


Scenario: able to see calendar prepopulated when editing
    When I try to update a calendar "calendar1"
    Then I should see the form filled for calendar "calendar1"

Scenario: able to see the updated changes after editing
    When I try to update a calendar "calendar1"
    And I change the values for calendar "calendar1" with the following: 103,public,yes
    Then I should see the values for calendar "calendar1" with the following: calendar1,103,public,fee_required_checked

Scenario: able to destroy a calendar
    When I delete calendar "calendar1"
    Then I should not see calendar "calendar1"
    
   

