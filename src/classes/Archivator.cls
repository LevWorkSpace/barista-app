public class Archivator implements Schedulable {

    public void execute(SchedulableContext param1) {
        try {
            List<DailyIncome__c> dailyIncome = new List<DailyIncome__c>();
            for (AggregateResult ar :  [
                    SELECT sum(TotalPriceWithDiscount__c) dayIncome, DAY_ONLY(createddate) date
                    FROM Bill__c
                    GROUP BY DAY_ONLY(createddate)
                    HAVING DAY_ONLY(createddate) != LAST_N_DAYS:20
                    ORDER BY DAY_ONLY(createddate)]) {
                Date day = (Date)ar.get('date');
                dailyIncome.add(new DailyIncome__c(
                        Name = String.valueOf(day),
                        Date__c = day,
                        Income__c = (Decimal)ar.get('dayIncome')
                ));
            }
            insert dailyIncome;

            delete [SELECT Id FROM Bill__c WHERE createddate != LAST_N_DAYS:20];
        } catch (Exception e) {
            insert new Log__c(Error__c = e.getMessage() + ' ' + e.getStackTraceString());
            throw e;
        }

    }
}