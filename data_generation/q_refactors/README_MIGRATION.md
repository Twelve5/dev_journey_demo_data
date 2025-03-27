# Product Data Migration

The product data CSV files need to be updated to match the schema specification. A migration script has been created to handle this update.

## What Changed
The script will:
1. Add missing required columns (UniqueId, Type)
2. Rename columns to match schema (Product Name -> Name)
3. Ensure consistent column ordering
4. Generate new GUIDs for each product

## How to Run Migration
1. From the make_data directory, run:
```bash
python migrate_product_data.py
```

2. The script will create new CSV files with "_migrated" suffix

3. After verifying the migrated files:
   - Backup original CSV files
   - Remove "_migrated" suffix from new files
   - Replace original files with migrated versions

## Validation
The migrated files will have all required columns as specified in schema-product.csv:
- UniqueId (GUID)
- Name (String) 
- Manufacturer (String)
- Type (String)
- [Product-specific columns]

This ensures compatibility with the updated ProductDataService code.