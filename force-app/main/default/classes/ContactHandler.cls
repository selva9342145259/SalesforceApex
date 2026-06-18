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
}