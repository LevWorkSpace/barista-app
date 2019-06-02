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

    @future
    private static void saveLog(String error) {
        insert new Log__c(Error__c = error);
    }

}