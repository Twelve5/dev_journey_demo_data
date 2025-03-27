Feature: Specifics about a Cropzone

    Scenario: Ensuring that a CropZone can be associated only with one Field
        Given a specific CropZone
        When I examine the number of Fields the Crop Zone is associated with 
        Then the count should be exactly 1. 

    Scenario: Ensuring that the Crop Zone is associated with a Crop
        Given a specific CropZone with a CropZoneCrop
        When I examine its CropZoneCrop
        Then the CropZoneCrop should not be empty
    
    Scenario: Ensuring that the associated crop is in the list of acceptable crops
        Given a specific CropZone
        When I examine its CropZoneCrop
        Then its value should be "<commodity_crops>"

    Examples:
    | commodity_crops   |
    | Corn              |
    | Soybeans          |
    | Wheat             |
    | Barley            |
    | Oats              |
    | Sorghum           |

    Scenario: Ensuring that CropZoneGeometry does not exceed FieldGeometry
        Given a CropZone with a Geometry
        And the Field the CropZone belongs to with a Field Geometry
        When I compare the boundaries of CropZone Geometry with Field Geometry
        Then the CropZone Geometry should be completely contained within the Field Geometry
    
    Scenario: Ensuring that CropZoneGeometry matches the declared CropZoneArea
        Given a specific CropZone with a declared Cropzone Area and CropZone AreaUoM
        And a Crop ZoneGeometry defining its boundary
        When I calculate the area from the CropZone Geometry
        Then the calculated area should be within 1% of the declared Cropzone Area

    Scenario: Ensuring that CropZone Season is within the allowed range
        Given a CropZone with a Season value
        When I validate the Season year
        Then the Season should be a year between 2015 and 2025 inclusive    

    Scenario: Ensuring a Field has CropZones for every season between 2015 and 2025
        Given a Field with one or more associated CropZones
        When I retrieve all CropZone Seasons for this Field
        Then there should be exactly one CropZone for each year between 2015 and 2025 inclusive
