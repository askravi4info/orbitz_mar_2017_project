Feature: Orbitz Flight Search Functionalities - OF8407

  Background:
    Given user is on Orbitz home page
    And user selects Round trip button under the flights tab

  @OF8407 @smoke
#Imperative Style
  Scenario: verify the user gets the valid flights available for the correct airports
    When user enters columbus and select Columbus, GA airport from the dep box
    And user enters cleveland and select Cleveland, OH airport from the arrival box
    And user selects the future date
    And click the search button
    Then user should be redirected to search results page with the title Select your departures
