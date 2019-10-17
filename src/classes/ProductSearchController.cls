public with sharing class ProductSearchController {
    @TestVisible private static final String SECTION_NAMES = 'sectionNames';
    @TestVisible private static final String SECTION_TO_PRODUCTS = 'sectionToProducts';

    @AuraEnabled
    public static Map<String, Object> getActiveProductsWithSections() {
        try {
            return new Map<String, Object> {
                    SECTION_NAMES => getOrderedSectionNames(),
                    SECTION_TO_PRODUCTS => getSectionToProducts()
            };
        } catch (Exception e) {
            TheMostAbstractUtility.logException('ProductSearchController.getActiveProductsWithSections', e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static Map<String, List<Product>> getSectionToProducts() {
        Map<String, List<Product>> sectionToProducts = new Map<String, List<Product>>();
        for (Product__c product : [SELECT Name, Cost__c, Type__c, Picture__c, Description__c
                                   FROM Product__c
                                   WHERE Active__c = true
                                   ORDER BY Type__c, Name]) {
            if (!sectionToProducts.containsKey(product.Type__c)) {
                sectionToProducts.put(product.Type__c, new List<Product>());
            }
            sectionToProducts.get(product.Type__c).add(new Product(product));
        }
        return sectionToProducts;
    }

    private static List<String> getOrderedSectionNames() {
        List<String> sectionNames = new List<String>();
        for (PicklistEntry availableType : Product__c.Type__c.getDescribe().getPicklistValues()) {
            sectionNames.add(availableType.getLabel());
        }
        return sectionNames;
    }

    public class Product {
        @AuraEnabled public String productId;
        @AuraEnabled public String name;
        @AuraEnabled public String description;
        @AuraEnabled public Decimal cost;
        @AuraEnabled public String picture;

        public Product(Product__c product) {
            this.name = product.Name;
            this.description = product.Description__c;
            this.cost = product.Cost__c;
            this.picture = product.Picture__c;
            this.productId = product.Id;
        }
    }
}