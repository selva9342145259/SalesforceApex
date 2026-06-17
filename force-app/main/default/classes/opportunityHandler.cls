public with sharing class opportunityHandler {

   public static void opportunityAmount(List<Opportunity> newOpp) {

    Set<id> accId = new Set<id>();

    for(Opportunity opp: newOpp){

        if(opp.AccountId!=null){

            accId.add(opp.AccountId);
        }
    }
        if(accId.isEmpty()){
            return;
        }
        Map<id, Account> accountMap = new Map<id, Account>([Select id, Rating  from Account where id IN:accId]);
        for(Opportunity opp : newOpp){
            Account acc = accountMap.get(opp.AccountId);
            if(opp.Amount==null){
                opp.addError('Amount Is Null');
                if( acc.Rating!='Hot' && opp.amount>100000){
                opp.addError('It should not allow Amount is Null and Rating is High');
                }
            }
        }
    }

// When an Opportunity is sent for approval:
// Approval_Status__c = Pending​
// Sales team should not modify important deal information until manager approval is completed. use Before Update
// block fields:

// Prevent updatig Amount
// Prevent changing Stage
public static void approvalUpdate(List<Opportunity> newOpp ,Map<Id,Opportunity> oldMap){
    User userProfile =[Select Profile.Name from user Where id = :UserInfo.getUserId()];
    for(Opportunity opp: newOpp){
        Opportunity oldOpp = oldMap.get(opp.Id);
        if(oldOpp.Approval_Status__c == 'Pending' &&  userProfile.Profile.Name == 'Sales User'&&(opp.Amount != oldOpp.Amount || opp.StageName != oldOpp.StageName )){
            opp.addError('Sales team should not modify important deal information until manager approval is completed');
        }
    }
}
}