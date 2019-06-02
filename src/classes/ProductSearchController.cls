public with sharing class ProductSearchController {

    @AuraEnabled
    public static List<Section> getActiveProducts() {
        try {
            Map<String, List<Product>> sectionToProducts = new Map<String, List<Product>>();
            for (Product__c product : [SELECT Name, Cost__c, Type__c, Picture__c, Description__c
                                       FROM Product__c WHERE Active__c = true ORDER BY Type__c, Name]) {
                if (!sectionToProducts.containsKey(product.Type__c)) {
                    sectionToProducts.put(product.Type__c, new List<Product>());
                }
                sectionToProducts.get(product.Type__c).add(new Product(product));
            }
            List<Section> sections = new List<Section>();
            for (PicklistEntry availableType : Product__c.Type__c.getDescribe().getPicklistValues()) {
                if (sectionToProducts.containsKey(availableType.getValue())) {
                    sections.add(new Section(availableType.getLabel(), sectionToProducts.get(availableType.getValue())));
                }
            }
            return sections;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class Section {
        @AuraEnabled public String name;
        @AuraEnabled public List<Product> products;

        public Section(String name, List<Product> products) {
            this.name = name;
            this.products = products;
        }
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