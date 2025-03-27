## Product Data Service Issues and Required Fixes

### Current Issues
1. CSV files are missing required columns that are defined in schema-product.csv:
   - Missing 'UniqueId' column
   - Missing 'Type' column
   - Has 'Product Name' instead of 'Name'

2. The code has been updated to expect schema-compliant column names, but the CSV files have not been updated to match.

### Required Fixes

1. Update all product CSV files in reference-data/ to include:
   - Add 'UniqueId' column with GUID values
   - Add 'Type' column with appropriate product type
   - Rename 'Product Name' column to 'Name'

2. Or alternatively, temporarily modify ProductDataService.py to work with existing CSV structure:
   - Revert column name changes
   - Add code to generate UniqueId values on the fly
   - Add code to set Type based on the DataFrame source

### Recommendation
The proper fix is to update the CSV files to match the schema, since:
1. The schema represents the desired structure
2. Having consistent column names across all files reduces maintenance burden
3. Having explicit Type and UniqueId fields makes the data more complete and self-documenting

### Implementation Plan
1. Create script to process all product CSV files:
   - Generate GUID for each product
   - Add Type column based on filename
   - Rename Product Name to Name
2. Run script to update all CSVs
3. Keep current ProductDataService.py changes that expect schema-compliant column names