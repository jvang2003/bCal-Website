Feature: department admin can CRUD calendars

	As a 'Dept Admin'
	I want to CRUD calendars (name, google keys, etc) 
	So that I can manage our calendars.

Background: calendars have been added to the database
    Given the following calendars exist:
    |calendar       |api-key | flag  |
    |calendar1      |123     |public |
    |calendar2      |345     |private|
  
    And I am on the department_admin page
    
Scenario: able to create calendar
    When I press "create new calendar"
    And I fill in the following: "calendar3" for "calendar","567" for "api-key","public" for "flag"
    And I press "Submit"
    Then I should see the following: calendar3,567

Scenario: able to read calendar
    When I follow "More about calendar2"
    Then I should see the following: calendar2_detail,calendar2,345,private #The google calendar,the calendar name, the api-key and the flag


Scenario: able to update calendar
    Given I am on the edit calendar 2 page
    When I fill in the following: "calendar4" for "calendar","678" for "api-key","private" for "flag"
    And I press "Submit"
    Then I should see the following: calendar4,678,private
    And I should not see the following: calendar2,345

Scenario: able to destroy calendar
    When I follow "More about calendar2"
    And I press "destroy"
    Then I should not see the following: calendar2,345
    
   

