trigger AccountTrigger on Account (before update) {
    if (Trigger.isBefore&&Trigger.isUpdate) {
         AccountHandler.accountPriyority(Trigger.oldMap,Trigger.New);
    }
       if (Trigger.isAfter&&Trigger.isInsert) {
        AccountController.relatedOpportunity(Trigger.new);
       }
       if(Trigger.isBefore&&Trigger.isUpdate){
          AccountHandler.adminOnlyEdit(Trigger.New);
       }
}