
Feature: Manage Feeds
  In order to be the master of the web
  As a logged in user
  I want to create and manage custom feeds from html pages

  Scenario: create new feed
    Given I am logged in as "artem"
    When I go to my feeds
    And I follow "new feed"
    And I fill in "name" with "Weatherdiff"
    And I fill in "url" with "http://www.weatherdiff.com"
    And I fill in "xpath" with '//*[@id="content"]'
    And I press "Create"
    Then I should see "feed created"

  Scenario: edit feed
    Given I am logged in as "artem"
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "edit"
    And I fill in "name" with "Weatherdiff2"
    And I press "Save"
    And I go to my feeds
    Then I should see "Weatherdiff2"

  Scenario: use feed
    Given I am logged in as "artem"
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "show"
    Then I should get "This is Weatherdiff," from "rss link" content

  Scenario: delete feed
    Given I am logged in as "artem"
    And there is a feed called "Weatherdiff"
    When I go to my feeds
    And I follow "destroy"
    And I press "yes"
    Then I should have no feeds
