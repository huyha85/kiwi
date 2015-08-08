@javascript
Feature: As a frontend developer
    I would like to view all checkins of a user

Background:
  Given I have a user with 3 checkins
  Given I have 2 checkins
  When I go to checkins page

Scenario: User's checkins
  When I select the user email from dropdown
  Then I should see 3 checkins

Scenario: All checkins
  Then I should see 5 checkins

Scenario: Larger than max checkins per page
  Given I have 25 checkins
  When I go to checkins page
  Then I should see 25 checkins
  When I click on '2'
  Then I should see 5 checkins
