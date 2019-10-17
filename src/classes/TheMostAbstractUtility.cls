public class TheMostAbstractUtility {

    public static void logException(String whereOccured, Exception e) {
        logError(whereOccured + ':' + e.getMessage() + ' ' + e.getStackTraceString());
    }

    @future
    public static void logError(String error) {
        insert new Log__c(Error__c = error);
    }

    public static String getRandomQuote() {
        Integer countQuotes = [SELECT count() from MotivationalQuote__c];
        if (countQuotes == 0) {
            return '';
        }
        Integer randomQuote = Math.floor(Math.random() * countQuotes).intValue();
        return [SELECT Quote__c FROM MotivationalQuote__c LIMIT 1 OFFSET :randomQuote].Quote__c;
    }
}