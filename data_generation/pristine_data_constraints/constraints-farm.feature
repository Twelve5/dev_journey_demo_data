Feature: Specifics about Farms

    Scenario: Ensuring that each farm has a realistic and manageable number of Fields
        Given a specific Farm
        When I examine the number of Fields belonging to the Farm
        Then the count is between 1 and 10

    Scenario: Ensuring that a Farm can be associated only with one Business
        Given a specific Farm
        When I examine the number of Businesses the Farm is associated with 
        Then the count should be exactly 1. 

    Scenario: Ensuring that the Business Name is populated
        Given a specific Farm
        When I examine its Farm Name
        Then the FarmName should not be empty
    