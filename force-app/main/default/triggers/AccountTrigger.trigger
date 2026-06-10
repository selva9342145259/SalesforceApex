trigger AccountTrigger on Account (before update) {
    if (Trigger.isBefore&&Trigger.isUpdate) {
         AccountHandler.accountPriyority(Trigger.oldMap,Trigger.New);
    }
       
}