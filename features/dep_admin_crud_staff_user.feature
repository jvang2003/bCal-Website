Feature: Department Admin should be able to CRUD staff users to calendars.

Background: Given I am logged in as a Dept admin
    Given the following staff users exist:
    | name            |     remember token           | role    | calnet_id    |
    | Ben             |     jsadjsud9834qoij3        | staff   | benner       |	 
    | Rick            |     8ujhj0wismjns9oko        | staff   | ricky        |

    Given the following calendars exist:
    | name            |     email                    | visib   | fee_required |disabled|
    | real google cal | bCalWebsiteTesting@gmail.com | public  | false        |true    |	 

	And I authenticate the calendar "real google cal" the refresh token "1/HOP_Fhq1XuuNWEc_DkDw0M7F8KG3I8YpFnXKGnjlbjs"

Scenario: Given I am on the edit calendar page
    If I assign Ben to real google cal
    And I should be on the homepage
    And I should see calendar successfully edited

Scenario: Given I am on the edit calendar page
    And I have assigned Ben to real google cal
    And I should be able to see Ben on the edit calendar page 

Scenario: Given I am on the edit calendar page
    And I have assigned Ben to real google cal
    And I assign Rick to real google cal
    Then I should be on the homepage
    And I should see calendar succesfully edited
 
