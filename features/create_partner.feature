Feature: Create Partner

  Scenario: Sucessfully create new partner
    When  I create a new partner
    Then  partner must be created
    # And   partner must be synced to other systems