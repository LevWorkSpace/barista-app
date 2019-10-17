public class Archivator implements Schedulable {

    public void execute(SchedulableContext param1) {
        Savepoint archivationFailed = Database.setSavepoint();
        try {
            ArchivatorService.archive();
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