@isTest
private class NewBillControllerTest {

    @isTest
    private static void testSuccess() {
        Bill__c bill = new Bill__c();
        List<ProductBill__c> billProducts = new List<ProductBill__c>();

        Test.startTest();
            NewBillController.saveBillWithProducts(bill, billProducts);
        Test.stopTest();

        System.assertEquals(1, [select count() from Bill__c]);
    }

    @isTest
    private static void testFailure() {
        Bill__c bill = new Bill__c();
        List<ProductBill__c> billProducts = new List<ProductBill__c> {
                new ProductBill__c()
        };

        Test.startTest();
            try{
                NewBillController.saveBillWithProducts(bill, billProducts);
                System.assert(false, 'Should be an exception');
            } catch (AuraHandledException e) {}
        Test.stopTest();

        System.assertEquals(0, [select count() from Bill__c], 'Should be rolled back');
    }
}