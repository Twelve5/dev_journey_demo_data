# Prompt 1: Project Scaffolding
You are provided with a specification for a Python 3.11 project that will introduce data anomalies ("bastardize" the data) in a mock Farm Management Information System (FMIS). You must generate the skeleton or scaffolding for this project, including a recommended directory structure, configuration files, and placeholders for source code and tests.

---

### 1. Why It Is Being Written

We have six CSV files (businesses, farms, fields, cropzones, products, operations) representing a fictional farm data model. We need a Python codebase that:

1. **Reads** these six CSVs.  
2. **Introduces anomalies** into the data based on certain probability-based rules.  
3. **Outputs** six new CSVs with the same columns, plus an extra column `bastardised` indicating whether that row was altered.  

We will ultimately fill in the detailed functionality in future prompts, but **this prompt is about setting up the project structure** so that subsequent modules can be easily slotted in.

---

### 2. How To Write It

- **Language**: Python 3.11.
- **Accepted External Libraries**: For example, `pandas` for CSV handling, `shapely` for geometry operations, and `numpy` or `random` for probabilities.
- **Project Structure**: We want something like:
fmiserrors/ ├── init.py ├── main.py # The main entry point ├── models.py # Data classes or typed structures for each entity ├── errors.py # Core "bastardizing" logic ├── utils.py # Helper functions (e.g., geometry manipulation, random utilities) ├── config/ │ ├── settings.py # Any global config or constants ├── tests/ │ ├── test_main.py │ ├── test_errors.py │ └── ... ├── requirements.txt # Dependencies ├── pyproject.toml # Or setup.cfg / setup.py if you prefer └── README.md # Overview
- **Use of Logging**: We will use Python's built-in logging library in each file where relevant.
- **Docstrings and Type Hints**: All functions and modules must contain docstrings (Google- or NumPy-style is fine) and type hints for clarity.
- **Testing**: We will use `pytest` (or `unittest`) in the `tests/` folder. For now, just placeholders are fine.

---

### 3. What To Write

#### Files to generate

1. **`fmiserrors/` package** with an `__init__.py`:
 - Empty or just set `__version__ = "0.1.0"`.
2. **`fmiserrors/main.py`**:
 - A placeholder `main()` function that logs: "FMIS Error Introducer started."
 - A `if __name__ == '__main__': main()`.
3. **`fmiserrors/models.py`**:
 - Placeholder data classes or stubs for: `Business`, `Farm`, `Field`, `Cropzone`, `Product`, `Operation`.
4. **`fmiserrors/errors.py`**:
 - A placeholder `bastardize_data()` function that logs: "Bastardizing data..."
5. **`fmiserrors/utils.py`**:
 - Placeholder utility function `parse_geometry()` that logs: "Parsing geometry..."
6. **`fmiserrors/config/settings.py`**:
 - Could store global constants or placeholders (e.g., probabilities).
7. **`tests/`** folder with placeholders:
 - **`test_main.py`** with a simple test that calls `main.main()` or checks the module is importable.
 - Additional placeholders like `test_errors.py`, `test_models.py`, etc.
8. **`requirements.txt`** with:
 - `pandas`
 - `shapely`
 - `pytest`
 - (Any other you consider necessary placeholders.)
9. **`pyproject.toml`** or a `setup.cfg` + `setup.py`:
 - Minimal metadata so it can be installed as a local package (`pip install -e .`).
10. **`README.md`**:
 - Summarize the project’s purpose, how to install, and how to run.

> Each file should include docstrings, logging statements, and type hints *where appropriate for now*. Because this is just scaffolding, the actual “logic” can be mostly placeholders or stubs.

---

### 4. Expected Inputs and Outputs

- **Inputs**: None at this stage (we're just building placeholders).
- **Outputs**: A set of files and folders as described, with placeholders that we will later fill in.

---

### 5. Acceptance Criteria

1. The codebase compiles/runs without errors in Python 3.11.
2. The folder structure matches the described layout (or close to it).
3. Each Python file has minimal docstrings, logging, and type hints.
4. There is a placeholder test suite that can be discovered by `pytest`.

---

### 6. Additional Details

- Although we will integrate the “bastardizing” rules later, be sure to keep the code modular so that reading CSVs, injecting anomalies, and writing out CSVs can be logically separated.
- Use standard Python logging conventions (e.g., `logger = logging.getLogger(__name__)` in each module).

Please **generate** all these files with the necessary placeholders. Remember to keep docstrings, logging, and type hints throughout.







---
# Prompt 2: Reading and Parsing the Input CSVs

You are provided with a specification for a Python 3.11 project that manipulates Farm Management Information System (FMIS) data. We have six CSV files, each representing a table: businesses.csv, farms.csv, fields.csv, cropzones.csv, products.csv, and operations.csv.

We have the following columns:

---------------------------------------------------------------------
businesses.csv  
  - bus_unique_id (Primary Key)
  - bus_name
  - bus_number_of_farms

farms.csv
  - farm_unique_id (Primary Key)
  - farm_name
  - farm_business_id (Foreign Key to business)
  - farm_number_of_fields 

fields.csv
  - field_unique_id (Primary Key)
  - field_name
  - field_farm_id (Foreign Key to farm)
  - field_geometry
  - field_area
  - field_area_uom

cropzones.csv
  - cz_unique_id (Primary Key)
  - cz_name
  - cz_field_id (Foreign Key to fields)
  - cz_season
  - cz_crop
  - cz_geometry
  - cz_area
  - cz_area_uom

products.csv
  - prod_unique_id (Primary Key)
  - prod_product_name
  - prod_manufacturer
  - prod_type
  - prod_approved_crop
  - prod_min_application_rate
  - prod_min_rate_uom
  - prod_max_application_rate
  - prod_max_rate_uom
  - prod_crop
  - prod_planting_notes

operations.csv
  - op_unique_id (Primary Key)
  - op_cropzone_id (Foreign Key to cropzone)
  - op_status
  - op_type
  - op_date
  - op_product_id (Foreign Key to product)
  - op_rate
  - op_rate_uom
  - op_area
  - op_area_uom
  - op_geometry
  - op_notes

---------------------------------------------------------------------
**Objective**: Create code that reads these CSVs into appropriate data structures, and places them in memory in a consistent format for the rest of the program to use. Each row will eventually gain an extra boolean column `bastardised`, but for now we simply want to read the original CSVs.

---

### 1. Why It Is Being Written

We need a robust way to ingest each CSV into either a `pandas.DataFrame` or a set of Python data classes/objects. This portion of the code will be used by the main script before we apply the error-injection logic.

---

### 2. How To Write It

- **Language**: Python 3.11
- **Libraries**: We can rely on `pandas` to read CSVs. We can also define data classes in `models.py`.
- **File Placement**:
  - We will add or update functions in:
    - `fmiserrors/utils.py` (for reading CSVs).
    - Potential expansions in `fmiserrors/models.py` to define typed classes.
  - If using data classes, be sure to parse columns into the correct data types.
- **Structure**:
  - Create a function like `load_all_csvs(input_dir: str) -> Dict[str, pd.DataFrame]`, which returns a dictionary containing DataFrames keyed by name: `"businesses"`, `"farms"`, `"fields"`, `"cropzones"`, `"products"`, `"operations"`.
  - Alternatively, if you prefer to parse directly into Python objects, you can do so—just ensure the data is accessible to the rest of the code.

Include docstrings, logging, type hints, and a “happy path” test in `tests/test_main.py` or in a new test file.

---

### 3. What To Write

Here is a concise list of the functions (feel free to rename):

1. **`load_all_csvs(input_dir: str) -> Dict[str, pd.DataFrame]`:**
   - Uses `pandas.read_csv` to read each of the six CSVs.
   - Returns a dict: 
     ```python
     {
       "businesses": <DataFrame>,
       "farms": <DataFrame>,
       "fields": <DataFrame>,
       "cropzones": <DataFrame>,
       "products": <DataFrame>,
       "operations": <DataFrame>
     }
     ```
   - Add a log statement each time a CSV is loaded.

2. Optionally, **`parse_to_models()`** (if you want to demonstrate converting the DataFrame rows to data classes in `models.py`). This is optional but can illustrate typed objects.

**Implementation details**:
- Use `os.path.join(input_dir, "<filename>.csv")` or similar for portability.
- If any CSV is missing or fails to load, log an error (but you can decide how strictly you want to handle it).

---

### 4. Expected Inputs and Outputs

- **Input**: A directory path containing these six CSV files.
- **Output**: A dictionary of DataFrames or a list of typed objects for each CSV.

---

### 5. Precise Acceptance Criteria

1. Code must successfully read all six CSVs.
2. Code must provide logging statements showing that each file was read.
3. Data in each DataFrame must match the CSV columns exactly, preserving column names.
4. All relevant Python files must contain docstrings with type hints.

---

### 6. Additional Information

- Make sure to keep the geometry columns (e.g., `field_geometry`, `cz_geometry`, `op_geometry`) as strings in the DataFrame for now. We will parse them into actual geometry objects later, if needed, using something like `shapely`.
- Remember that the smaller LLM has no context from previous prompts, so any references to the existing structure must be repeated. (For this prompt, simply assume the folder structure is already in place from the “Project Scaffolding” step.)






------------
# Prompt 3: Implementing the Anomaly (Error) Injection Logic

We have six CSV tables: businesses, farms, fields, cropzones, products, and operations. We will read them into memory, then "bastardize" them by applying the following rules to each table. Each row in the final CSVs will have a boolean column `bastardised` indicating if an error was introduced.

Below is the summary of all the anomaly rules, with example probabilities. Your code should be written to allow easy modification of these probabilities.

---
### The Anomaly Rules

1. **(1% chance)** Change the area UoM for a field, cropzone, or operation to one of `[oxgang, virgate, carucate, oods, perches, virgates]`.

2. **(3% chance)** A cropzone has an "absurd season" (< 1995 or > 2030).

3. **(3% chance)** A cropzone is missing between 1 and all-but-1 of its operations (i.e., partial or near-complete removal of operations tied to that cropzone).

4. **(2% chance)** An operation’s `op_rate` is set to 10–15% higher than the product’s approved max rate *or* 10–15% lower than the product’s approved min rate.

5. **(2% chance)** For a “Crop Protection” operation, switch its product to another product of the same type (e.g. herbicide to herbicide) that is *not* approved for that crop.

6. **(1% chance)** For a “Crop Protection” operation, truncate the product name to just the first word.

7. **(1% chance)** A field’s `field_area` is increased or decreased by 5–15% without changing the geometry, and that area change also applies to the associated cropzones and operations that share that field.

8. **(1% chance)** An operation date (`op_date`) has a year added or subtracted (±1 year).

9. **(1% chance)** A field is left with no geometry (`field_geometry = None`), and all related cropzones and operations also have no geometry.

10. **(1% chance)** A cropzone’s `cz_crop` is either set to blank or replaced with a random vegetable name.

11. **(1% chance)** A field’s geometry is scaled up by 10,000%, with its area increased by a corresponding amount.

12. **(1% chance)** For an operation, depending on its type, we do text transformations on `op_notes`:
    - If we detect a hyphen between letters (e.g., "pre-emergence"), randomly replace that hyphen with whitespace or remove it.
    - If we find Roman numerals like "II" or "III", replace them with "2" or "3", etc.
    - If the operation is a “seed” type and has brand names like `DEKALB`, `BECK'S`, `ASGROW`, `PIONEER`, remove those brand strings from the notes.
    - Replace "Ammonium Nitrate" with "NH4NO3".
    - Replace "Potassium Chloride" with "KCl".
    - Replace "Urea" with "CH4N2O".

13. **(2% chance)** An operation’s `op_rate_uom` is swapped for another valid UOM of the *same type* (mass, volume, or count).

14. **(1% chance)** An operation’s `op_rate_uom` is swapped for a valid UOM of a *different* type (mass -> volume, etc.).

---
### Valid UoMs for Product Applications

(Each has a "Type": Volume per Area, Mass per Area, Volume per Mass, Count per Area. Swaps within the same type go in rule #13; cross-type swaps are rule #14.)

UOM	Type
fl oz/ac	Volume per Area
gal/ac	Volume per Area
L/ac	Volume per Area
L/ha	Volume per Area
pt/ac	Volume per Area
qt/ac	Volume per Area
bu/ac	Volume per Area*
lb/ac	Mass per Area
oz/ac	Mass per Area
kg/ha	Mass per Area
g/m²	Mass per Area
ton/ha	Mass per Area
cwt/ac	Mass per Area
gal/ton	Volume per Mass
qt/ton	Volume per Mass
pt/ton	Volume per Mass
L/ton	Volume per Mass
mL/kg	Volume per Mass
seeds/ac	Count per Area
seeds/ha	Count per Area
seeds/ft²	Count per Area
plants/ac	Count per Area
plants/m²	Count per Area

---

### 1. Why It Is Being Written

We need a single module or set of functions that can take the data from the six tables (in memory, presumably as `pandas.DataFrame`s or dictionaries of data classes) and systematically apply these anomalies. This logic must also mark each row that is changed with `bastardised = True`. If a row is not changed, `bastardised = False`.

---

### 2. How To Write It

- **Language**: Python 3.11
- **Libraries**: We can use `random` or `numpy.random` to handle probabilities. For geometry changes, we can rely on `shapely` for scaling polygons, removing geometry, etc. If you are not comfortable with shapely, you can manipulate the geometry strings in a simpler manner—but for major expansions (like 10,000% scale), shapely is more robust.
- **Recommended Approach**:
  - Create a function, e.g., `bastardize_data(dfs: Dict[str, pd.DataFrame], probabilities: Dict[str, float]) -> Dict[str, pd.DataFrame]]`.
  - Or break it down by entity type (fields, cropzones, products, operations, etc.) in separate functions if you prefer.

Be sure to keep your code **modular**: each rule can be its own function, or you can have one function that loops the rows and calls sub-rules in sequence.

- **File placement**: code belongs in `fmiserrors/errors.py` (and possibly geometry utility functions in `fmiserrors/utils.py`).

Also remember: 
- We only apply certain rules to certain tables. 
- Keep track of foreign keys (e.g., if you remove geometry from a field, remove geometry from its linked cropzones and operations).
- For the rule that removes operations, we might physically drop rows from `operations` DataFrame for that cropzone.

Use logging statements to describe which rule is being applied and to how many rows.

---

### 3. What To Write (List of Functions)

Here is a suggested breakdown:

1. **`bastardize_data(dfs: Dict[str, pd.DataFrame]) -> Dict[str, pd.DataFrame]`:**
   - Orchestrates the entire process, calling sub-rule functions in random order or a known order.
   - Returns the updated DataFrames (with the added `bastardised` column if not present).

2. **Rule-specific functions**, e.g.:
   - `apply_area_uom_swap(...)`
   - `apply_absurd_season(...)`
   - `apply_cropzone_missing_ops(...)`
   - `apply_operation_rate_violations(...)`
   - `apply_crop_protection_product_swap(...)`
   - `apply_crop_protection_product_truncation(...)`
   - `apply_field_area_adjustment(...)`
   - `apply_operation_date_shift(...)`
   - `apply_field_no_geometry(...)`
   - `apply_cropzone_crop_randomization(...)`
   - `apply_field_geometry_scale(...)`
   - `apply_operation_notes_text_replacements(...)`
   - `apply_operation_rate_uom_swap_same_type(...)`
   - `apply_operation_rate_uom_swap_diff_type(...)`

   You do not *have* to split them exactly like this, but modularity is recommended for testing. Each function can loop through the relevant rows, apply the random logic with the set probability, and mark `bastardised = True` for changed rows.

3. **Geometry helpers** (in `utils.py`) if using shapely:
   - `scale_polygon(geom, factor: float) -> str` (returns updated GeoJSON or WKT string).
   - `remove_polygon(geom) -> None or str` returning `None`.

---

### 4. Expected Inputs and Outputs

- **Input**: A `dict` of DataFrames (the original data).
- **Output**: A `dict` of DataFrames (the “bastardized” data), each row potentially changed and containing a new boolean `bastardised` column.

---

### 5. Precise Acceptance Criteria

1. **Each row that is altered** has `bastardised = True`. Unaltered rows have `bastardised = False`.
2. The code uses the specified probabilities for each type of anomaly (they should be easily adjustable constants or config entries).
3. The code applies geometry changes consistently for fields, their child cropzones, and operations (where required).
4. Logging is present to show which rules are triggered and how many rows are affected.

---

### 6. Additional Notes

- For random vegetables, you can keep a small list like `["Carrot", "Broccoli", "Spinach", ...]`. 
- For the brand removal or text replacements, do simple string replacements on `op_notes`.
- For the partial removal of operations from a cropzone, ensure you never remove *all* operations if the rule says “missing between 1 and all except 1.”

This should give you enough detail to implement the entire anomaly logic. Remember to maintain robust docstrings, logging, and type hints.




---

# Prompt 4: Writing Out the Anomalized CSVs

We have a Python codebase that reads six CSVs, modifies the data with “bastardizing” rules, and must now write out six new CSVs with the extra column `bastardised`.

---

### 1. Why It Is Being Written

After we have applied anomalies, we need to produce final CSV outputs—one for each table—so that the data can be used for demos.

---

### 2. How To Write It

- **Language**: Python 3.11
- **Libraries**: `pandas` is acceptable for writing CSVs.
- **Structure**:
  - A function `write_all_csvs(output_dir: str, dfs: Dict[str, pd.DataFrame]) -> None` that writes each DataFrame to CSV.
  - Possibly a main function in `main.py` that ties everything together:
    - `dfs = load_all_csvs(input_dir)`
    - `bastardized_dfs = bastardize_data(dfs)`
    - `write_all_csvs(output_dir, bastardized_dfs)`

We must ensure each output CSV has all original columns plus the `bastardised` column at the end.

---

### 3. What To Write

1. **`write_all_csvs(output_dir: str, dfs: Dict[str, pd.DataFrame]) -> None`:**
   - For each key in `dfs`, write out `<key>.csv` to `output_dir`.
   - Ensure the CSV includes the same column order as the input plus the new `bastardised` column.

2. A **`main()`** function in `main.py` that:
   - Accepts command-line arguments or config for `input_dir` and `output_dir`.
   - Calls `load_all_csvs()`.
   - Calls `bastardize_data()`.
   - Calls `write_all_csvs()`.
   - Logs appropriate messages.

Include docstrings, logging, and type hints. Provide a minimal usage example in the docstring or a `README.md` update.

---

### 4. Expected Inputs and Outputs

- **Input**: The dictionary of data (or via `load_all_csvs()`).
- **Output**: Six CSV files, each with an extra `bastardised` column.

---

### 5. Acceptance Criteria

1. The CSVs can be read back in by `pandas` and found to have the new column plus the original columns.
2. All logging statements appear as expected.
3. The code does not break if the output directory does not exist (either create it or raise an informative error).

---

### 6. Additional Info

- Make sure that the final CSV column order is correct. If you read as DataFrame, you can do something like:
  ```python
  columns_order = list(original_columns) + ["bastardised"]
  df.to_csv(..., columns=columns_order, index=False)
Alternatively, just ensure the new column is appended at the end (pandas will typically do that by default if you add the new column last).
---




## Prompt 5: **Testing the Anomaly Rules and Workflow**

We have a project that:

Loads six CSVs into memory.
Injects errors (bastardizes data).
Outputs new CSVs.
Now we need to write tests—focusing especially on the error-injection logic. We want each rule tested for correctness and coverage.

1. Why It Is Being Written
Confidence in our anomaly injection is critical. We must ensure each rule (area UoM changes, geometry removal, date shifts, etc.) is triggered when expected and that the final data includes a bastardised = True for altered rows.

2. How To Write It
Language: Python 3.11
Libraries: pytest is recommended.
File Location: Inside the tests/ folder (e.g., test_errors.py).
We will create unit tests that:

Feed in mock or sample data frames with a known structure and limited rows.
Force certain probabilities to 100% for a given rule to ensure that rule is tested in isolation.
Check that the resulting data is changed as expected.
Use fixtures for test data if you want (pytest.fixture) or inline data creation.

3. What To Write (Tests to Include)
test_area_uom_swap():

Provide a sample DataFrame with known field_area_uom values.
Force the swap probability to 1.0.
Ensure that the resulting field_area_uom is changed to one of the archaic units [oxgang, virgate, etc.].
test_absurd_season():

Provide a cropzones DataFrame with a normal cz_season.
Force the absurd-season probability to 1.0.
Confirm that cz_season ends up < 1995 or > 2030 for all rows.
test_missing_operations():

Provide a small cropzones DataFrame plus an operations DataFrame with multiple ops per zone.
Force probability to 1.0.
Check that each zone is missing some but not all operations.
test_operation_rate_violations(), etc.

You can keep going for each rule. The key is to isolate each anomaly and confirm it did what we expect. Also ensure that bastardised is set to True.

4. Expected Inputs and Outputs
Input: Mock DataFrames or test CSV data.
Output: Passing tests that confirm each rule is correctly implemented.
5. Acceptance Criteria
Each test passes when the code is correct.
Each rule is tested at least once with forced 100% probability.
Logging can be verified if you wish, or you can rely on data checks.
6. Additional Details
If you prefer a single “mega test” that verifies multiple rules at once, that’s fine, but we recommend discrete unit tests per rule for clarity.
Remember to keep docstrings, type hints, and optionally logging statements in your test code too, though minimal logging in tests is typical.






---

## How to Use These Prompts

1. **Open** your smaller LLM interface.
2. **Copy** the entire text of Prompt #1 and **paste** it into your smaller LLM. Instruct it to generate the code exactly as specified. That will give you the project scaffolding.
3. **Repeat** for Prompt #2, #3, #4, and #5, in whichever order you need—ensuring you always provide the entire prompt so the smaller LLM has the full context.

By following the **acceptance criteria** in each prompt, you should end up with a coherent, fully functional Python 3.11 codebase that:

- Reads the six CSVs (businesses, farms, fields, cropzones, products, operations).
- Applies the specified anomaly rules with controllable probabilities.
- Produces six new CSVs with the same schema plus a `bastardised` column.
- Provides thorough unit tests to ensure correctness and coverage.

Each prompt **stands alone**, so you may see repetition, but that is **by design** to help the smaller LLM reconstruct the entire solution in each step. Good luck building your FMIS data “bastardizer”!
