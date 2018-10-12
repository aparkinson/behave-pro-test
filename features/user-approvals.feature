Feature: User Approvals

  @ORPHAN
  Scenario: User should not be able to ready a story with unresolved questions
    Given an unapproved story
    When a user with unresolved questions tries to approve
    Then the story should not be approved
    And a message should appear

  @ORPHAN
  Scenario: User approves a user story when there are unresolved questions
    Given a User Story has unresolved questions created by Nick
    When Nick tries to approve the User Story
    Then Notify Nick that there are outstanding questions
    When Nick continues with the Approval
    Then Nick's open questions should be resolved

  @ORPHAN
  Scenario: Create a new Question on a User Story
    Given a open User Story
    When Nick creates a question
    Then Nick's question is visible to all other users
    And Nick's questions is created as a comment on the User Story

  @ORPHAN
  Scenario: Create a new Question on a User Story with resolved Questions
    Given a User Story with resolved Questions
    When Nick creates a question
    Then Nick's question is visible to all other users
    And Nick's questions should appear above resolved questions in the question list

  @ORPHAN
  Scenario: User creates a Question on a User Story they have already approved
    Given a User Story that Nick has already marked as ready
    When Nick creates a question on the User Story
    Then Nick's approval for the User Story should be removed
    And Nick's open questions are resolved automatically
    And Nick's open questions are resolved automatically

  @ORPHAN
  Scenario: Resolve your own Question
    Given a User Story that Nick has a open Question on
    And no other open Questions
    When Nick resolves his Question
    Then Nick's question is in the resolved state
    And the Question Button count should be 0

  @ORPHAN
  Scenario: Resolve a Question from another User
    Given a User Story that Nick has a open Question on
    When Charlie tries to resolve Nick's question
    Then Nick's question remains open

  @ORPHAN
  Scenario: User has a open question on a User Story
    Given a User Story that Nick has a open Question on
    When Nick marks the User Story as Ready
    Then Nick's open questions are resolved automatically

  @ORPHAN
  Scenario: Copy of Create a new Question on a User Story
    Given a open User Story
    When Nick creates a question
    Then Nick's question is visible to all other users
    And Nick's questions is created as a comment on the User Story
