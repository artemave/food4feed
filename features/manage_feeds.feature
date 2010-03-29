
Feature: Manage Feeds
  In order to be the master of the web
  As a logged in user
  I want to create and manage custom feeds from html pages

  Background:
    Given I am logged in

  Scenario: create new feed
    When I am on the list of feeds
    And I follow "New Feed"
    And I fill in "feed[channel_name]" with "Weatherdiff"
    And I fill in "feed[channel_link]" with "http://www.weatherdiff.com"
    And I fill in "feed[item_title_selector]" with "p:nth-child(3)"
    And I fill in "feed[item_description_selector]" with "#location_list"
    And I press "Create Feed"
    Then I should see "created successfully"

  Scenario: edit feed
    Given there is a test feed
    When I go to the list of feeds
    And I follow "Edit"
    And I fill in "Name" with "Weatherdiff2"
    And I press "Save"
    And I go to my feeds
    Then I should see "Weatherdiff2"

  Scenario: use feed
    Given there is a test feed
    When I go to the list of feeds
    And I follow "Weatherdiff"
    Then I should see "This is Weatherdiff,"
    And I should see "number of locations"

  Scenario: delete feed
    Given there is a test feed
    When I go to the list of feeds
    And I follow "destroy"
    And I press "yes"
    Then I should have no feeds
