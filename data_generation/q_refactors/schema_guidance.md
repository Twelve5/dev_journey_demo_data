# Schema and Test File Guidance

## RMIS Raw Schema Policy
The `rmis-raw-schema.csv` file is considered the source of truth for the data set and should not be modified. This file represents the agreed-upon schema definition that all stakeholders have approved.

## Cucumber Test File Enhancements
While the schema file should remain unchanged, developers are encouraged to enhance the cucumber test files by:

1. Adding more detailed test scenarios
2. Including additional test cases
3. Introducing parameterized tests
4. Adding metadata that can be parsed programmatically

These enhancements to the cucumber tests can help make the test generation code more:
- Generic
- Reusable
- Maintainable
- Comprehensive

## Best Practices
When enhancing cucumber tests:
1. Ensure all additions align with the existing schema
2. Focus on making the test code more modular and reusable
3. Document any new test patterns or parameters added
4. Consider adding helper methods that can be reused across different test scenarios

## Implementation Note
The schema file serves as a contract between different components of the system. Any needed changes to the data structure should be discussed and agreed upon by all stakeholders before implementation.