public with sharing class ContactHandler {
    // While creating Contact:
// Prevent duplicate Email
// But allow duplicate if Account Rating = Hot
public static void preventDuplicateEmail(List<Contact> conNew){

    Set<String> emails = new Set<String>();
    Set<Id> accIds = new Set<Id>();

    for(Contact con : conNew){
        if(con.Email != null)
            emails.add(con.Email);

        if(con.AccountId != null)
            accIds.add(con.AccountId);
    }

    Map<String,Contact> contactMap = new Map<String, Contact>();

    Map<Id,Account> accountMap =
        new Map<Id,Account>(
            [SELECT Id, Rating
             FROM Account
             WHERE Id IN :accIds]
        );

    for(Contact con : [
        SELECT Email
        FROM Contact
        WHERE Email IN :emails
    ]){
        if(con.Email != null){
            contactMap.put(con.Email, con);
        }
    }

    for(Contact con : conNew){

        if(
            con.Email != null &&
            contactMap.containsKey(con.Email) &&
            (
                !accountMap.containsKey(con.AccountId) ||
                accountMap.get(con.AccountId).Rating != 'Hot'
            )
        ){
            con.addError('Duplicate Email');
        }
    }
}
// Allow Only One Primary Contact per Account
// Business Requirement
 
// Each customer Account should have only one Primary Contact.
 
// Whenever a Contact is inserted or updated:
 
// Rules
// If Primary__c = TRUE, verify that no other Contact under the same Account is already marked as Primary.
// If another Primary Contact already exists, prevent the save.
// Show the error:
// Only one Primary Contact is allowed for an Account.
    public static void primaryContact(List<Contact> conNew){
    Set<id> accIds = new Set<id>();
    for(Contact con: conNew){
        if(con.AccountId != null &&con.Primary__c == true){
                accIds.add(con.AccountId);
        }
    }
   Map<id, Id> accountContact = new Map<id, id>();
   for(Contact con :[ Select id, AccountId from Contact Where AccountId IN : accIds and Primary__c = true]){
            if(con.AccountId != null){
                accountContact.put(con.AccountId,con.id);
            }
        }
            for(Contact con : conNew){
                if(con.AccountId == null || con.Primary__c != true){ 
                    continue; 
                }
                if(accountContact.containsKey(con.AccountId)&&accountContact.get(con.AccountId) != con.Id){
                        con.addError('Only One primary contact allowed for account');
                }
            }
   }
}