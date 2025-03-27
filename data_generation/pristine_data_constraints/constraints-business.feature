Feature: Specifics about Businesses

    Scenario: Ensuring that each Business has a realistic and manageable number of farms
        Given a specific Business
        When I examine the number of Farms belonging to the Business
        Then the count is between 1 and 5

    Scenario: Ensuring that the Business Name is populated
        Given a specific Business
        When I examine its BusinessName
        Then the BusinessName should not be empty

    Scenario: Ensuring that the Business Name is 'business-like'
        Given a specific Business
        When I examine its Business Name
        Then the name is indicative of a business, e.g. suffixed by LLC with an Agricultural spin.