//Trigger on Case
trigger CaseTrigger on Case (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert ){
            //execute after case create              
            CaseTriggerHandler.onAfterInsert(Trigger.new);
        }
        if(!CaseTriggerHalper.willBeRecursive){
            //Set static variable true to avoid recursion
            CaseTriggerHalper.willBeRecursive = true;
            if(Trigger.isUpdate){ 
                //execute after case update 
                CaseTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
            }
            //Set static variable false
            CaseTriggerHalper.willBeRecursive = false;
        }
    }
}