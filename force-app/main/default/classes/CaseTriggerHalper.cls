public class CaseTriggerHalper {
    //Define Static Variable
    public static boolean willBeRecursive = false;
    
    //Create Nonconformance when case Type 'Problem'
    public static void createNonconformance(List<Case> caseList){
        
        List<SQX_Nonconformance__c> noncList = new List<SQX_Nonconformance__c>();
        for(Case cs : caseList){
            if(cs.Type == 'Problem'){
                noncList.add(createNonConf(cs));
            }
        }
        
        if(noncList.size() > 0){
            INSERT noncList;                
        }
        if(noncList != NULL && caseList != NULL){
            updateCase(noncList, caseList);
        }
    }
    
    //Create Nonconformance when case Type update to 'Problem'
    public static void updateNonconformance(List<Case> caseList, Map<Id,Case> caseOldMap){
        Set<Id> noncIds = new Set<Id>();
        for(Case cs : caseList){
            if(cs.SQX_NC_Reference__c != NULL){
                noncIds.add(cs.SQX_NC_Reference__c);
            }
        }
        Map<String,Id> nonMap = new Map<String,Id>();
        for(SQX_Nonconformance__c non : [Select id, QMS_Reference_Number__c from SQX_Nonconformance__c Where Id IN: noncIds]){
            nonMap.put(non.QMS_Reference_Number__c, non.Id);
        }
        List<SQX_Nonconformance__c> noncList = new List<SQX_Nonconformance__c>();
        List<SQX_Nonconformance__c> noncUpdateList = new List<SQX_Nonconformance__c>();
        for(Case cs : caseList){
            if(cs.Type == 'Problem' && cs.Type != caseOldMap.get(cs.Id).Type && cs.SQX_NC_Reference__c == NULL && !nonMap.containsKey(cs.CaseNumber) && cs.CreatedById == cs.LastModifiedById){
                noncList.add(createNonConf(cs));
            }else if(cs.Type == 'Problem' && cs.SQX_NC_Reference__c != caseOldMap.get(cs.Id).SQX_NC_Reference__c && cs.SQX_NC_Reference__c != NULL && nonMap.containsKey(cs.CaseNumber)){
                noncUpdateList.add(updateNonconformance(cs,nonMap));
            }
        }
        
        if(noncList.size() > 0){
            INSERT noncList;                
        }
        if(noncUpdateList.size() > 0){
            UPDATE noncUpdateList;
        }        
        if(noncList != NULL && caseList != NULL){
            updateCase(noncList, caseList);
        }
    }
    
    //Assign Nonconformance values from Case
    public static SQX_Nonconformance__c createNonConf(Case cs){
        SQX_Nonconformance__c  nonc = new SQX_Nonconformance__c(
            Priority__c = cs.Priority,
            Title__c = cs.Subject,
            Description__c = cs.Description,
            QMS_Reference_Number__c = cs.CaseNumber
        );
        return nonc;
    }
    //Update Nonconformance on case 
    public static void updateCase(List<SQX_Nonconformance__c> noncList,List<Case> caseList){
        Map<String,Id> ncMap = new Map<String,Id>();
        for(SQX_Nonconformance__c nc : noncList){
            ncMap.put(nc.QMS_Reference_Number__c,nc.Id);
        }
        
        List<Case> caseUpdate = new List<Case>();
        for(Case cs : caseList){
            if(ncMap.containsKey(cs.CaseNumber)){
                Case c = new Case();
                c.Id = cs.Id;
                c.SQX_NC_Reference__c = ncMap.get(cs.CaseNumber);
                caseUpdate.add(c);
            }
        } 
        if(caseUpdate.size() > 0){
            UPDATE caseUpdate;
        }
    }
    
    //Update Existing Nonconformance Record
    public static SQX_Nonconformance__c updateNonconformance(Case cs, Map<String,Id> nonMap){
        SQX_Nonconformance__c nc = new SQX_Nonconformance__c(
            Id = nonMap.get(cs.CaseNumber),
            Priority__c = cs.Priority,
            Title__c = cs.Subject,
            Description__c = cs.Description,
            QMS_Reference_Number__c = cs.CaseNumber);
        return nc;
    }    
}