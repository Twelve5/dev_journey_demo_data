# Implemented Constraints

The following constraints have been implemented in the data generator:

## Business Constraints
- Business names now include agricultural terms and LLC suffix
- Each business has 1-5 farms (random)

## Crop Zone Constraints
- Only allowed crops are used (corn, soybeans, wheat, barley, oats, sorghum)
- Each field has exactly one crop zone per year from 2015-2025
- Crop zone geometry is properly contained within field geometry
- Crop zone area is between 50-100% of field area
- Area calculations within 1% accuracy (using geometric area calculation)

## Validation
The implementation has been split into focused modules:
- name_generator.py: Handles business name generation
- crops.py: Manages allowed crops and valid seasons
- geometry_utils.py: Ensures proper geometric containment