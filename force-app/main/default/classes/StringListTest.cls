public class StringListTest {

    // Public static method that accepts an integer and returns a list of strings
    public static List<String> generateStringList(Integer n) {
        
        // Initialize an empty list of strings
        List<String> result = new List<String>();

        // Use a loop to add 'Test n' strings
        for (Integer i = 0; i < n; i++) {
            result.add('Test ' + i);
        }

        // Return the final list
        return result;
    }
}