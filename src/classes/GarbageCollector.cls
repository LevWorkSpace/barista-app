public class GarbageCollector implements Schedulable {

    public void execute(SchedulableContext param1) {
        try {
            delete [SELECT Id FROM Bill__c WHERE Archived__c = true AND createddate != LAST_N_DAYS:20];
        } catch (Exception e) {
            saveLog(e.getMessage() + ' ' + e.getStackTraceString());
            throw e;
        }
    }

    @future
    private static void saveLog(String error) {
        insert new Log__c(Error__c = error);
    }
}