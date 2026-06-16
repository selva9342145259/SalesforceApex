public with sharing class AccountHandler {

public static  void accountPriyority(Map<id, Account> oldAccounts,List<Account> newAcc){

for (Account acc : newAcc) {
    Account oldAccount =oldAccounts.get(acc.id);
    if(acc.AnnualRevenue!=null && acc.AnnualRevenue!=oldAccount.AnnualRevenue && acc.AnnualRevenue>50000000){
        acc.Rating='Hot';
    }
}
}
// If Account Tier becomes : Hot
// Update all related Opportunities
//→ Priority = High
 public static void relatedOpportunity(List<Account> newAcc) {
    Set<id> accId = new Set<id>();
    for(Account acc: newacc) {
        if(acc.Rating!=null && acc.Rating == 'Hot'){
            accId.add(acc.Id);
        }
    }
    List<Opportunity> updateOpportunity = new List<Opportunity>();
    List<Opportunity> opp = [Select Rating from Opportunity where AccountId IN : accId];
    for (Opportunity oppLoop : opp) {
        oppLoop.Rating ='High';
        updateOpportunity.add(oppLoop);
    }
    update updateOpportunity;
}
// If Account Rating = Hot:
// Only System Admin can edit it
public static void adminOnlyEdit(List<Account> newAcc) {
    User currentUser = [Select Profile.Name from User Where id =:UserInfo.getUserId() Limit 1];
    for (Account acc : newAcc) {
        if(acc.Rating=='Hot'&&currentUser.Profile.Name != 'System Administrator'){
                    acc.addError('Object can Modify only Admin');
        }
        
    }

    }
//     If Account rating = hot:
// Share Account with Regional Director.
public static void accountShare(List<Account> accNew){
    List<AccountShare> shares = new List<AccountShare>();

    User userId =[Select id from User where profile.Name ='Sales User' Limit 1]; 
   for(Account acc: accNew) {
        if(acc.Rating!= null && acc.Rating == 'Hot'){
            shares.add(new AccountShare( AccountId =acc.Id,UserOrGroupId = userId.Id,AccountAccessLevel ='Edit',OpportunityAccessLevel ='Read',CaseAccessLevel = 'Read',RowCause =Schema.AccountShare.RowCause.Manual
            ));
        }
   }
   if(!shares.isEmpty) insert shares;
}
}