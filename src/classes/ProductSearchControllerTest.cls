@isTest
private class ProductSearchControllerTest {

    @isTest
    private static void testSuccess() {
        insert new List<Product__c> {
                new Product__c(Name = 'Test', Active__c = true),
                new Product__c(Name = 'Test2', Active__c = false)
        };

        Test.startTest();
            List<ProductSearchController.Section> sections = ProductSearchController.getActiveProducts();
        Test.stopTest();

        System.assertEquals(1, sections.size());
        System.assertEquals('Drinks', sections[0].name);
        System.assertEquals(1, sections[0].products.size());
        System.assertEquals('Test', sections[0].products[0].name);
    }
}