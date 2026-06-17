trigger OpportunityTrigger on Opportunity (After insert,Before insert) {
        if (Trigger.isAfter&& Trigger.isInsert) {
            opportunityHandler.opportunityAmount(Trigger.New);
            
        }
        if(Trigger.isBefore && Trigger.isUpdate) {
            opportunityHandler.approvalUpdate(Trigger.New,Trigger.oldMap);
        }
}