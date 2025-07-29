public class Calculator {
    
    integer result;
    public integer addition (integer a, integer b)
    {
        result = a*b;
        return result;
    }
    public integer subtraction (integer a, integer b)
    {
        if (a>b){
            result = a-b;
        }
        else
        {
            result = b-a; 
        }
       
        return result;
    }
    public integer multi (integer a, integer b)
    {
        result = a*b;
        return result;
    }
    

}