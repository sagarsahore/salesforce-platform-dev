public with sharing class listCollection {
    public listCollection() {
        List<String> fundType = new List<String> { 'Growth', 'Balanced', 'Conservative', 'Focused growth' };

        for(Integer i=0; i < fundType.size(); i++){
            System.debug(fundType[i]);
        }
           // Bonus: print them on one line too
        System.debug('All funds: ' + String.join(fundType, ', '));
    }
}