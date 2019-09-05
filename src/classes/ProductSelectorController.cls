public with sharing class ProductSelectorController {

    @AuraEnabled(cacheable=true)
    public static Map<String, List<Product>> getProductsBySection() {
        try {
            return getSectionToProducts();
        } catch (Exception e) {
            saveLog(e.getMessage());
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

    @future
    private static void saveLog(String error) {
        insert new Log__c(Error__c = error);
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