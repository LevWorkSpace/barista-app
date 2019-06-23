<?xml version="1.0" encoding="UTF-8"?>
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <applicationVisibilities>
        <application>coffee_house</application>
        <default>true</default>
        <visible>true</visible>
    </applicationVisibilities>
    <classAccesses>
        <apexClass>NewBillController</apexClass>
        <enabled>true</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>NewBillControllerTest</apexClass>
        <enabled>true</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ProductSearchController</apexClass>
        <enabled>true</enabled>
    </classAccesses>
    <classAccesses>
        <apexClass>ProductSearchControllerTest</apexClass>
        <enabled>true</enabled>
    </classAccesses>
    <custom>true</custom>
    <fieldPermissions>
        <editable>false</editable>
        <field>Bill__c.BillCode__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Bill__c.CreatedDateTime__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Bill__c.Discount__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Bill__c.PaymentMethod__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Bill__c.TotalPriceWithDiscount__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Bill__c.TotalPrice__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Log__c.Error__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ProductBill__c.Amount__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ProductBill__c.Cost__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ProductBill__c.Discount__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>ProductBill__c.TotalCost__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Product__c.Active__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Product__c.Cost__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Product__c.Description__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Product__c.Picture__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>false</editable>
        <field>Product__c.ProductCode__c</field>
        <readable>false</readable>
    </fieldPermissions>
    <fieldPermissions>
        <editable>true</editable>
        <field>Product__c.Type__c</field>
        <readable>true</readable>
    </fieldPermissions>
    <layoutAssignments>
        <layout>Bill__c-Barista Bill Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Log__c-Log Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>ProductBill__c-Barista Product Bill Layout</layout>
    </layoutAssignments>
    <layoutAssignments>
        <layout>Product__c-Barista Product Layout</layout>
    </layoutAssignments>
    <loginIpRanges>
        <endAddress>255.255.255.255</endAddress>
        <startAddress>0.0.0.0</startAddress>
    </loginIpRanges>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Bill__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Log__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>true</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>ProductBill__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <objectPermissions>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <object>Product__c</object>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>
    <tabVisibilities>
        <tab>Bill__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Log__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>NewBill</tab>
        <visibility>DefaultOn</visibility>
    </tabVisibilities>
    <tabVisibilities>
        <tab>Product__c</tab>
        <visibility>Hidden</visibility>
    </tabVisibilities>
    <userLicense>Salesforce</userLicense>
    <userPermissions>
        <enabled>false</enabled>
        <name>AllowUniversalSearch</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ApexRestServices</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>ApiEnabled</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>AssignTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ChatterFileLink</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ContentWorkspaces</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ConvertLeads</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>CreateCustomizeFilters</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>CreateCustomizeReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>CreateTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>DistributeFromPersWksp</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EditEvent</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EditOppLineItemUnitPrice</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EditTask</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EditTopics</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EmailMass</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EmailSingle</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EnableCommunityAppLauncher</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>EnableNotifications</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ExportReport</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ImportPersonal</name>
    </userPermissions>
    <userPermissions>
        <enabled>true</enabled>
        <name>LightningExperienceUser</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ListEmailSend</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>MassInlineEdit</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>RunReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>SelectFilesFromSalesforce</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>SendSitRequests</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ShowCompanyNameAsUserBadge</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>SubmitMacrosAllowed</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>SubscribeToLightningReports</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>TransactionalEmailSend</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>UseWebLink</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ViewRoles</name>
    </userPermissions>
    <userPermissions>
        <enabled>false</enabled>
        <name>ViewSetup</name>
    </userPermissions>
</Profile>
