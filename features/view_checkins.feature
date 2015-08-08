@javascript
Feature: As a frontend developer
    I would like to view all checkins of a user

Background:
  Given I have a user with 3 checkins
  Given I have 2 checkins
  When I go to checkins page

Scenario:
  When I select the user email from dropdown
  Then I should see 3 checkins

Scenario:
  Then I should see 5 checkins 
  