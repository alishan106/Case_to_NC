@isTest
public class CaseTriggerTest {
    
    @isTest
    public static void createCaseTest(){
        Case caseObj = new Case(
            SuppliedEmail = 'alizeeshan106@gmail.com',
            SuppliedPhone = '08299336143',
            Type = 'Problem',
            Status = 'New',
            Origin = 'Email',
            Subject = 'Test',
            Description = 'Test Case',
            Priority = 'Medium');
        
        Test.startTest();
        insert caseObj;
        System.assertEquals('Test Case', caseObj.Description, 'Expected Case created');
        Test.StopTest();
        
    }
    
    @isTest
    public static void updateCaseTest(){
        Case caseObj = new Case(
            SuppliedEmail = 'alizeeshan106@gmail.com',
            SuppliedPhone = '08299336143',
            Type = 'Other',
            Status = 'New',
            Origin = 'Email',
            Subject = 'Test',
            Description = 'Test Case',
            Priority = 'Medium');
        
        Test.startTest();
        insert caseObj;
        caseObj.Type = 'Problem';
        Update caseObj;
        System.assertEquals('Problem', caseObj.Type, 'Case updated');
        Test.StopTest();
    }
}