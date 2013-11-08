Feature: Public user can enter details about events

	As a 'Public User'
	I want to enter my email, dept, reason, number of people, if it's course related and if I'd accept a different room when I reserve a location 
	So that I can submit as much detail about my event as possible.

Background: calendars have been added to the database
    Given the following calendars exist:
    |name           |key |visib  | fee_required |disabled |
    |calendar1      |123 |public | true         |true     |
    |calendar2      |345 |private| false        |false    |
  
    And I am logged in as a public user
    
Scenario: able to add details
    When I try to reserve a room with calendar calendar1
    Then I will be able to fill in abc@gmail.com, EECS, infosession, 30, no, yes
    
   
