Feature: Typical Operations on a Corn CropZone

    # Planting
    Scenario: Validate that a Corn Planting Operation occurs within its CropZone's Season
        Given an Operation of type "Planting" with a Product of type "Seed" and Crop = "Corn"
        And the CropZone that the Operation belongs to
        When I retrieve the year from the operationDate
        And I retrieve the Season year of the CropZone
        Then both values must be equal

    Scenario: Validate that a Corn Planting Operation occurs between April 1st and May 31st
        Given an Operation of type "Planting" with a Product of type "Seed" and Crop = "Corn"
        When I retrieve its operationDate in "YYYY-MM-DD" format
        Then the operationDate must be between "YYYY-04-01" and "YYYY-05-31" (inclusive)

    Scenario: Validate that a Corn Planting Operation has the correct Rate Unit of Measure (UoM)
        Given an Operation of type "Planting" with a Product of type "Seed" and Crop = "Corn"
        When I examine its RateUoM
        Then its value should be "seeds/ac"

    Scenario: Validate that a Corn Planting Operation has a rate within an acceptable Range
        Given an Operation of type "Planting" with a Product of type "Seed" and Crop = "Corn"
        When I examine its Rate
        Then its value should be between 22,000 and 38,000

    # Harvest
   Scenario: Validate that a Corn Harvest Operation occurs within its CropZone's Season
        Given an Operation of type "Harvest" with a Product of type "Seed" and Crop = "Corn"
        And the CropZone that the Operation belongs to
        When I retrieve the year from the operationDate
        And I retrieve the Season year of the CropZone
        Then both values must be equal

    Scenario: Validate that a Corn Harvest Operation occurs between Sept 1st and Oct 31st
        Given an Operation of type "Harvest" with a Product of type "Seed" and Crop = "Corn"
        When I retrieve its operationDate in "YYYY-MM-DD" format
        Then the operationDate must be between "YYYY-09-01" and "YYYY-10-31" (inclusive)

    
     Scenario: Validate that a Corn Harvest Operation has the correct Rate Unit of Measure (UoM)
        Given an Operation of type "Harvest" with a Product of type "Seed" and Crop = "Corn"
        When I examine its RateUoM
        Then its value should be "bu/ac"

    Scenario: Validate that a Corn Harvest Operation has a rate within an acceptable Range
        Given an Operation of type "Harvest" with a Product of type "Seed" and Crop = "Corn"
        When I examine its Rate
        Then its value should be between 70 and 350

    # Nutrition - Fall Fertilizer Application
    