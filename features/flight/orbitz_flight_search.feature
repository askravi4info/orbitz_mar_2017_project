@orbitz_flights @qa

Feature: Orbitz Flight Search Functionality - OF8407

  Background:
    Given user is on Orbitz home page
    And user selects Round trip button under the flights tab

  @OF8407 @smoke
#Imperative Style
  Scenario: verify the user gets the valid flights available for the correct airport
    When user enters columbus and select Columbus, GA airport from the dep box
    And user enters cleveland and select Cleveland, OH airport from the arrival box
    And user selects the future date
    And click the search button
    Then user should be redirected to search results page with the title Select your departures

  @regression
  Scenario: verify the user is warned when trying to search for past date flights in orbitz
    When user enters columbus and select Columbus, GA airport from the dep box
    And user enters cleveland and select Cleveland, OH airport from the arrival box
    And user selects the past date
    And click the search button
    Then user should be warned with the following message - Returning date is in the past. Please enter a valid returning date.

  @wip
  #    Declarative Style
  Scenario: verify the user gets the valid flights available for the correct airport(declarative style)
    When user searches for the valid airports for future date
    Then user should be redirected to search results with the valid available flights

    @manual
  Scenario: verify the flight results are displayed by sort order of price
    When user searches for the valid airports for future date
    Then verify the flight results are displayed by sort order of price


  Scenario Outline: verify the user gets the valid flights available for the mid-west airports
    When user enters <dep_city_name> and select <dep_airport_name> airport from the dep box
    And user enters <arr_city_name> and select <arr_airport_name> airport from the arrival box
    And user selects the future date
    And click the search button
    Then user should be redirected to search results page with the title Select your departure

    Examples:
      | dep_city_name | dep_airport_name | arr_city_name | arr_airport_name |
      | columbus      | Columbus, GA     | cleveland     | Cleveland, OH    |
      | chicago       | chicago, IL      | kansas        | Wichita, KS      |


  Scenario: verify the user is warned when trying to search with wrong information
    When user enters columbus and select Columbus, GA airport from the dep box
    And user selects the past date
    And click the search button
    Then user should be warned with the following messages:
      | message_details                                                     |
      | Returning date is in the past. Please enter a valid returning date. |
      | Please complete the highlighted destination field below.            |
      | Departing date is in the past. Please enter a valid departing date. |
      | fklasdjfklsadfj                                                     |

    Scenario: Testing yml functionality
      Then verify the yml functionality works


