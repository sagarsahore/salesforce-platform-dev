//Q5. You have List<Account> accs with mixed Industries. Remove every element where 
//Industry == 'Education' safely in one pass (no ConcurrentModification issues). 
// Show two valid approaches with just Lists.

public with sharing class removeElement {
    public removeElement() {
        removeEducationAccounts(accs);
    }
    public static void removeEducationAccounts(List<Account> accs) {
         if (accs == null || accs.isEmpty()) return;
        for (Integer i = accs.size() - 1; i >= 0; i--) {
            if (accs[i].Industry == 'Education') accs.remove(i);
        }
    }
    //Alternative Approach
    public static void removeEducationAccounts2(List<Account> accs) {
        if (accs == null || accs.isEmpty()) return;
        List<Account> keepers = new List<Account>(accs.size());
        for (Account a : accs) {
            if (a.Industry != 'Education') keepers.add(a);
        }
        accs.clear();
        accs.addAll(keepers);
    }
}