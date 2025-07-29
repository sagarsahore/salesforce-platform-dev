trigger CreateDummyContacTriggert on Account (before insert)
{
    List <Contact> contactList = new List<Contact>();
    for(Account acc:Trigger.new)
    {
        
        Contact con = new Contact();
        con.LastName = acc.name;
        con.firstName = 'Dummy';
        con.AccountId = acc.id;
        con.MailingCity= acc.BillingCity;
        con.MailingState=acc.BillingState;
        Con.MailingStreet=acc.BillingStreet;
        contactList.add(con);
    }
    insert contactList;
    
    
}