public class TheMostAbstractUtility {

    public static void logException(String whereOccured, Exception e) {
        logError(whereOccured + ':' + e.getMessage() + ' ' + e.getStackTraceString());
    }

    @future
    public static void logError(String error) {
        insert new Log__c(Error__c = error);
    }
}