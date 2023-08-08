/*
Class Name		: AccountTriggerHandler
Author			: Anshul sahu
Created date	: 08/08/2023
Description 	: This helper class used in AccountTrigger
*/

public class AccountTriggerHandler {
    //create Contact default While Acount is Active = true and customer type = Customer if a default contact does not exist.
    public static void createDefaultContact(List<Account> newList, Boolean isInsert, Map<Id,Account> oldMap){
        Set<Id> accIds = new Set<Id> (); //for Store the Account ids
        List<Contact> conList = new List<Contact>(); //for Store the contacts
        for(Account acc:newList){
            if((isInsert || acc.Active__c !=oldMap.get(acc.Id).Active__c) && acc.Active__c == true && acc.Type == System.label.Customer ){
                accIds.add(acc.Id);
            }
        }
        if(accIds.size()>0){
            List<account> accList = [SELECT Id, Name, Phone, Company_Email__c, (SELECT Id FROM Contacts LIMIT 1) FROM Account WHERE Id IN:accIds];
            for(Account ac:accList){
                if(ac.contacts.size()==0){
                    Contact con =  CreateContact(ac);
                    conList.add(con);
                }
            }
            if(conList.size()>0)
                Database.insert(conList) ; // insert the contact
        }
    }
/*****************************************************
* Method Name 	: createContact
* Author     	: Anshul sahu
* Description	: This method is  used to create and return the contact
* Created Date	: 08/08/2023
* Related Component : createDefaultContact
*****************************************************/
    public static Contact createContact(Account acc){
        Contact con = new Contact();
        con.firstName = acc.Name;
        con.lastName = System.label.Customer_Repre;
        con.Phone = acc.Phone;
        con.Email = acc.Company_Email__c;
        con.AccountId = acc.id;
        return con;
    }
}