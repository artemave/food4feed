
Feature: Manage Feeds
  In order to be the master of the web
  As a logged in user
  I want to create and manage custom feeds from html pages

  Scenario: create new feed
    Given I am logged in 
    When I am on the list of feeds
    And I follow "New Feed"
    And I fill in "Name" with "Weatherdiff"
    And I fill in "Link" with "http://www.weatherdiff.com"
    And I fill in "Title" with 'p:nth-child(3)'
    And I fill in "Description" with '#location_list'
    And I press "Create Feed"
    Then I should see "created successfully"

  Scenario: edit feed
    Given I am logged in 
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "Edit"
    And I fill in "Name" with "Weatherdiff2"
    And I press "Save"
    And I go to my feeds
    Then I should see "Weatherdiff2"

  Scenario: use feed
    Given I am logged in 
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "Weatherdiff"
    Then I should see "This is Weatherdiff,"
    And I should see "number of locations"

  Scenario: delete feed
    Given I am logged in 
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "destroy"
    And I press "yes"
    Then I should have no feeds
