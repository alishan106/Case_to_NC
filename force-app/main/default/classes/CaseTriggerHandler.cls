public class CaseTriggerHandler {
    
    public static void onAfterInsert(List<Case> caseList){
        //Case Helper call to create Nonconformance record when case create
        CaseTriggerHalper.createNonconformance(caseList);
    }
    
    public static void onAfterUpdate(List<Case> caseList, Map<Id,Case> caseOldMap){
        //Case Helper call to create Nonconformance record when case update
        CaseTriggerHalper.updateNonconformance(caseList,caseOldMap);
    }
}