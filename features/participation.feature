Feature: Participation
  In order to have attendance at presentations
  As a registered user
  I want to register my attendance

  Background:
    Given there is a user with firstname "John", surname "Doe", email "john.doe@gmail.com" and password "password"
    And I am logged in as an user with email "john.doe@gmail.com" and password "password"
    And there is a upcoming presentation titled Statoildagen

  Scenario: Attend presentation
    Given I am on the presentation page for "Statoildagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the success
    And a user named "John Doe" should be on the attendance list for "Statoildagen"

  Scenario: Cancel attendance
    Given "John Doe" is on the attendance list for "Statoildagen"
    And I am on the presentation page for "Statoildagen"
    When I follow "Meld meg av!"
    Then I should see a message explaining the success
    And a user named "John Doe" should not be on the attendance list for "Statoildagen"

  Scenario: Cancel attendance for past presentation
    Given there is a past presentation titled Vismadagen
    And "John Doe" is on the attendance list for "Vismadagen"
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg av!"
    Then I should see a message explaining the error
    And a user named "John Doe" should be on the attendance list for "Vismadagen"

  Scenario: Attending past presentation
    Given there is a past presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a user named "John Doe" should not be on the attendance list for "Vismadagen"

  Scenario: Attending canceled presentation
    Given there is a canceled presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a user named "John Doe" should not be on the attendance list for "Vismadagen"

  Scenario: Attending full presentation
    Given there is a full presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a user named "John Doe" should not be on the attendance list for "Vismadagen"
