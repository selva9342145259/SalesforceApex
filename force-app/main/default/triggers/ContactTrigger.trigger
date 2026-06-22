trigger ContactTrigger on Contact (before insert) {
        if(Trigger.isBefore && Trigger.isInsert){
            ContactHandler.preventDuplicateEmail(Triggger.new);
        }
        if(Trigger.isBefore &&( Trigger.isInsert || Trigger.isUpdate)){
            ContactHandler.primaryContact(Trigger.New);
        }
}