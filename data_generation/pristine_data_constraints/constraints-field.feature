Feature: Specifics about Field

    Scenario: Ensuring that a Field can be associated only with one Farm
        Given a specific Field
        When I examine the number of Farms the Field is associated with 
        Then the count should be exactly 1. 

    Scenario: Ensuring that the Field Name is populated
        Given a specific Field
        When I examine its FieldName
        Then the FieldName should not be empty
    
    Scenario: Ensuring that the Area UoM is acceptable
        Given a specific Field
        When I examine its FieldAreaUoM
        Then its value should be "<area_uom>"

    Examples:
    | area_uom   |
    | acres      |
    | hectares   |
    | sq_meters  |


    Scenario: Ensuring that the size of the area is acceptable
        Given a specific Field
        When the FieldAreaUoM is "<area_uom>"
        Then the FieldArea should be between <min_size> and <max_size>

    Examples:
    | area_uom   | min_size | max_size |
    | acres      | 50       | 2500     |
    | hectares   | 20       | 1000     |
    | sq_meters  | 5000     | 1000000  |


    Scenario: Ensuring that FieldGeometry matches the declared FieldArea
        Given a specific Field with a declared FieldArea and FieldAreaUoM
        And a FieldGeometry defining its boundary
        When I calculate the area from the FieldGeometry
        Then the calculated area should be within 1% of the declared FieldArea

    Scenario: Ensuring that FieldGeometry boundaries fall within North America
        Given a specific Field with a FieldGeometry
        When I extract its latitude and longitude coordinates
        Then all latitude values should be between 5 and 85 degrees north
        And all longitude values should be between -168 and -52 degrees west
    
    Scenario: Ensuring that FieldGeometry represents a structured field boundary
        Given a specific Field with a FieldGeometry
        When I extract the boundary coordinates
        Then the number of primary edges should be between 4 and 8
        And the majority of angles should be close to 90 degrees
        And the bounding box dimensions should have an aspect ratio between 1:1 and 1:5

    