public class testclass1 {

    public void generateEvenStringList(Integer count) {
        List<String> result = new List<String>();

    for(Integer i = 0; i < count; i++) {
        if (Math.mod(i, 2) == 0) {
            result.add('Even number: ' + i);
        }
        result.add('Odd number: ' + i);
    }
    System.debug(result);
    return result;
}
}