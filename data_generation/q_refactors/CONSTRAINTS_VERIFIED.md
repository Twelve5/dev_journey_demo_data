# Constraints Implementation Status

All constraints from the `constraints/` folder have been implemented:

## Business Constraints
- ✓ 1-5 farms per business
- ✓ Business names populated and business-like
- ✓ Agricultural terms and LLC suffix

## Farm Constraints
- ✓ 1-10 fields per farm
- ✓ Single business association
- ✓ Farm names populated and descriptive

## Field Constraints
- ✓ Single farm association
- ✓ Field names populated
- ✓ Valid area units (acres/hectares/sq_meters)
- ✓ Valid area ranges per unit
- ✓ Geometry matches declared area
- ✓ North America boundaries
- ✓ 4-8 edges with ~90° angles

## CropZone Constraints
- ✓ Single field association
- ✓ Valid crop types from allowed list
- ✓ Geometry contained within field
- ✓ Area matches geometry
- ✓ Valid seasons (2015-2025)
- ✓ One zone per season

## Operation Constraints
- ✓ Valid operation types
- ✓ Valid operation status
- ✓ Valid date ranges per crop/operation
- ✓ Valid rates and UoMs per crop/operation
- ✓ Geometry contained within crop zone
- ✓ One planting/harvest per crop zone