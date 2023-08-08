/*
Class Name   		: AccountTrigger
Author		 		: Anshul sahu
Created date 		: 08/08/2023
Related Component 	: AccountTriggerHandler
*/
trigger AccountTrigger on Account ( Before insert, before update, After insert, After update) {
    if( trigger.isAfter){
        //create Contact default While Acount is Active = true
        AccountTriggerHandler.createDefaultContact(trigger.New,trigger.isInsert,trigger.oldmap);
    }
}