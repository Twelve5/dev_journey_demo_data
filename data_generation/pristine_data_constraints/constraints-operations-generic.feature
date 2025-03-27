Feature: Features common to all operations

    Scenario: Ensuring that an operation can only be linked to a CropZone
        Given a specific Operation
        When I examine the number of CropZones the Operation is associated with 
        Then the count should be exactly 1. 
    
    Scenario: Ensuring that the operation has an acceptable Type
        Given a specific Operation
        When I examine its Type
        Then its value should be "<operation_type>"

    Examples:
    | operation_type    |
    | Planting          |
    | Nutrition         |
    | Crop Protection   |
    | Harvest           |

    Scenario: Ensuring that the operation has an acceptable Status
        Given a specific Operation
        When I examine its Status
        Then its value should be "<operation_status>"

    Examples:
    | operation_status  |
    | Planned           |
    | Recommended       |
    | Actual            |

    Scenario: Ensuring that an Operation's Geometry does not exceed CropZone Geometry
        Given an Operation with a Geometry
        And the CropZone the Operation belongs to with a Geometry
        When I compare the boundaries of the Operation Geometry with the CropZone Geometry
        Then the Operation Geometry should be completely contained within the CropZone Geometry
    
    Scenario: Ensuring that Operation Geometry matches the declared Operation Area
        Given a specific Operation with a declared Area and AreaUoM
        And a CGeometry defining its boundary
        When I calculate the area from the Geometry
        Then the calculated area should be within 1% of the declared Area

    # Planting Stuff
    Scenario: Ensuring a CropZone has exactly one Planting operation
        Given a specific CropZone
        When I examine the Types of all Operations associated with it
        Then there should be exactly one Operation of type "Planting"

    Scenario: Ensuring a Planting operation has an acceptable Product linked
        Given an Operation of type "Planting"
        When I examine its Product
        Then the Product should be of type "Seed"

    # Harvest Stuff
    Scenario: Ensuring a CropZone has exactly one Harvest operation
        Given a specific CropZone
        When I examine the Types of all Operations associated with it
        Then there should be exactly one Operation of type "Harvest"

    Scenario: Ensuring a Harvest operation has an acceptable Product linked
        Given an Operation of type "Harvest"
        When I examine its Product
        Then the Product should be of type "Seed"




 

