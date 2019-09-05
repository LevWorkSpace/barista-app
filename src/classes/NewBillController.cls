public with sharing class NewBillController {

    @AuraEnabled
    public static void saveBillWithProducts(Bill__c bill, List<ProductBill__c> billProducts) {
        Savepoint noProductsNoBillSavepoint = Database.setSavepoint();
        try {
            insert bill;

            for (ProductBill__c productBill : billProducts) {
                productBill.Bill__c = bill.Id;
            }
            insert billProducts;

        } catch(Exception e) {
            Database.rollback(noProductsNoBillSavepoint);
            saveLog(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Bill__c getPreviousBill(Integer offsetValue) {
        try {
            return [SELECT CreatedDate, Discount__c, PaymentMethod__c, TotalPriceWithDiscount__c, TotalPrice__c,
                        (SELECT Id, Product__r.Name, TotalCost__c, Discount__c, Cost__c, Amount__c FROM ProductBills__r)
                    FROM Bill__c
                    ORDER BY CreatedDate DESC
                    LIMIT 1
                    OFFSET :offsetValue];

        } catch(Exception e) {
            saveLog(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @future
    private static void saveLog(String error) {
        insert new Log__c(Error__c = error);
    }

}