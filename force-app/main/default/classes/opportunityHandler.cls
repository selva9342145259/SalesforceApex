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
  }
