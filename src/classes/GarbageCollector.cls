public class GarbageCollector implements Schedulable {

    public void execute(SchedulableContext param1) {
        try {
            delete [SELECT Id FROM Bill__c WHERE Archived__c = true AND createddate != LAST_N_DAYS:20];
        } catch (Exception e) {
            TheMostAbstractUtility.logException('GarbageCollector', e);
            throw e;
        }
    }
}