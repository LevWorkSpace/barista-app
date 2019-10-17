public class Archivator implements Schedulable {

    public void execute(SchedulableContext param1) {
        Savepoint archivationFailed = Database.setSavepoint();
        try {
            Map<Date, Decimal> dayToIncome = new Map<Date, Decimal>();
            List<Bill__c> bills = [SELECT TotalPriceWithDiscount__c, createddate
            FROM Bill__c WHERE Archived__c = false];
            for (Bill__c b : bills) {
                if (!dayToIncome.containsKey(b.createddate.date())) {
                    dayToIncome.put(b.createddate.date(), 0);
                }
                b.Archived__c = true;
                dayToIncome.put(b.createddate.date(), dayToIncome.get(b.createddate.date())+ b.TotalPriceWithDiscount__c);
            }
            update bills;

            List<DailyIncome__c> dailyIncome = new List<DailyIncome__c>();
            for (Date day : dayToIncome.keySet()) {
                dailyIncome.add(new DailyIncome__c(
                        Name = String.valueOf(day),
                        Date__c = day,
                        Income__c = dayToIncome.get(day)
                ));

            }
            insert dailyIncome;
        } catch (Exception e) {
            Database.rollback(archivationFailed);
            TheMostAbstractUtility.logException('Archivator', e);
            throw e;
        }
    }

    /** Execute to achieve all
    List<DailyIncome__c> dailyIncome = new List<DailyIncome__c>();
    for (AggregateResult ar :  [
            SELECT sum(TotalPriceWithDiscount__c) dayIncome, DAY_ONLY(createddate) date
            FROM Bill__c
            GROUP BY DAY_ONLY(createddate)]) {
        Date day = (Date)ar.get('date');
        dailyIncome.add(new DailyIncome__c(
                Name = String.valueOf(day),
                Date__c = day,
                Income__c = (Decimal)ar.get('dayIncome')
        ));
    }
    insert dailyIncome;
    */
}