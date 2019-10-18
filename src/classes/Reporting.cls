public class Reporting implements Schedulable, Database.AllowsCallouts {

    public void execute(SchedulableContext param1) {
        try {
            Decimal dailyTotal = getDailyTotal();
            new TelegramReporter().sendDailyTotal(dailyTotal);
        } catch (Exception e) {
            TheMostAbstractUtility.logException('Reporting.execute: ', e);
        }
    }

    private static Decimal getDailyTotal() {
        AggregateResult result = [SELECT sum(TotalPriceWithDiscount__c) dailyTotal FROM Bill__c WHERE CreatedDate = TODAY];
        return result.get('dailyTotal') == null ? 0 : (Decimal)result.get('dailyTotal');
    }
}