public class ArchivatorService {

    public static void archive() {
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
    }

    public static void collectOld() {
        delete [SELECT Id FROM Bill__c WHERE Archived__c = true AND createddate != LAST_N_DAYS:20];
    }
}