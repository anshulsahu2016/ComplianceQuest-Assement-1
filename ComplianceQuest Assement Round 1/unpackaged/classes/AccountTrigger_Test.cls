/*
Class Name		: AccountTrigger_Test
Author			: Anshul sahu
Created date	: 08/08/2023
Dependent Test Class : AccountTrigger , AccountTriggerHandler
*/
@isTest
public class AccountTrigger_Test {
    /** 
    * ******************************************************
    * This method is test data for create Account
    * ******************************************************
    */
    public static testMethod void accountTrigger_Test() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        UserRole userRole = [SELECT Id FROM UserRole WHERE Name='COO'];
        
        //Create our test user
        User u = new User(
            alias = 'random', email='random@salesforce.com', 
            emailencodingkey='UTF-8', lastname='random', 
            localesidkey='en_US', languagelocalekey='en_US',
            profileid = p.Id, userroleid = userRole.Id,
            timezonesidkey='America/Los_Angeles',
            username='randomus@salesforceTest.com'
        );
        //Insert user record
        insert u;
        
        //Perform logic on account within the system.runAs() block
        System.runAs(u) {
            //create account record
            Account a = new Account(name='Test',Active__c=true ,Type=System.label.Customer,Account_Activation_Summary__c='Test summary');
            insert a;
            System.assertEquals('Test', a.Name);
        }
    }
      /** 
    * ******************************************************
    * This method is test data for create Account
    * ******************************************************
    */
    public static testMethod void accountTrigger2_Test() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        UserRole userRole = [SELECT Id FROM UserRole WHERE Name='COO'];
        
        //Create our test user
        User u = new User(
            alias = 'random', email='random@salesforce.com', 
            emailencodingkey='UTF-8', lastname='random', 
            localesidkey='en_US', languagelocalekey='en_US',
            profileid = p.Id, userroleid = userRole.Id,
            timezonesidkey='America/Los_Angeles',
            username='random@salesforceTest.com'
        );
        //Insert user record
        insert u;
        
        //Perform logic on account within the system.runAs() block
        System.runAs(u) {
            //create account record
            List<Account> accList = new  List<Account>();
            Account a = new Account(name='Test2',Active__c=true ,Type=System.label.Customer,Account_Activation_Summary__c='Test summary2');
            Account a1 = new Account(name='Test23',Active__c=true,Account_Activation_Summary__c='Test summary33');
            accList.add(a);
            accList.add(a1);
            insert accList;
            System.assertEquals('Test2', a.Name);
        }
    }
}