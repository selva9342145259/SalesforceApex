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
}