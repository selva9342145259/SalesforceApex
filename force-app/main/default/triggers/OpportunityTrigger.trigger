trigger OpportunityTrigger on Opportunity (After insert) {
        if (Trigger.isAfter&& Trigger.isInsert) {
            opportunityHandler.opportunityAmount(Trigger.New);
            
        }
}