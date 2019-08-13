@isTest
private class ProductSearchControllerTest {

    @isTest
    private static void testSuccess() {
        insert new List<Product__c> {
                new Product__c(Name = 'Test', Active__c = true),
                new Product__c(Name = 'Test2', Active__c = false)
        };

        Test.startTest();
            Map<String, Object> productsWithSections = ProductSearchController.getActiveProductsWithSections();
        Test.stopTest();

        System.assert(productsWithSections.containsKey(ProductSearchController.SECTION_NAMES));
        System.assert(productsWithSections.containsKey(ProductSearchController.SECTION_TO_PRODUCTS));
        System.assertEquals(Product__c.Type__c.getDescribe().getPicklistValues().size(),
                           ((List<String>)productsWithSections.get(ProductSearchController.SECTION_NAMES)).size());
        Map<String, List<ProductSearchController.Product>> products = (Map<String, List<ProductSearchController.Product>>)productsWithSections.get(ProductSearchController.SECTION_TO_PRODUCTS);
        System.assertEquals(1, products.size());
        System.assertEquals(1, products.values().size());
    }
}