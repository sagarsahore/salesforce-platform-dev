// Goal: Merge two String lists into a single list that
//  1) keeps the order of first appearance, and
//  2) contains no duplicates,
// using ONLY Lists (no Set/Map allowed).

public with sharing class MergeLists {

    /**
     * Merges two lists while preserving first-seen order and removing duplicates.
     * Example:
     *   a = ['X','Y','Z','Y'], b = ['Y','Z','W']  ->  ['X','Y','Z','W']
     *
     * Why this works:
     * - We build a new empty list `merged`.
     * - We walk through `a`, then `b`.
     * - Before adding each item, we check if `merged` already has it (using List.contains).
     * - If not present, we add it. This ensures each value appears only once,
     *   and the order is the order we first encountered it.
     */
    public static List<String> mergeUniqueOrdered(List<String> a, List<String> b) {
        // This will hold the final result
        List<String> merged = new List<String>();

        // If 'a' is not null, scan it from left to right
        if (a != null) {
            for (String s : a) {
                // Only add 's' if we haven't seen it before
                if (!merged.contains(s)) {
                    merged.add(s);
                }
            }
        }

        // Do the same for 'b'—still preserving first appearance overall
        if (b != null) {
            for (String s : b) {
                if (!merged.contains(s)) {
                    merged.add(s);
                }
            }
        }

        // Return the combined, de-duplicated list
        return merged;
    }

    // --- Quick self-test you can run in your org ---
    @IsTest
    private static void testMerge() {
        List<String> a = new List<String>{'X','Y','Z','Y'};
        List<String> b = new List<String>{'Y','Z','W'};

        // Expected: 'X' (first time in a), 'Y' (first in a), 'Z' (first in a), 'W' (first time in b)
        List<String> expected = new List<String>{'X','Y','Z','W'};

        System.assertEquals(expected, mergeUniqueOrdered(a, b), 'Merged list did not match expected result');

        // Edge cases
        System.assertEquals(new List<String>{'A'}, mergeUniqueOrdered(new List<String>{'A'}, null));
        System.assertEquals(new List<String>(), mergeUniqueOrdered(new List<String>(), new List<String>()));
        System.assertEquals(new List<String>{'A','B'}, mergeUniqueOrdered(new List<String>{'A','B'}, new List<String>{'A','B'}));
    }
}
