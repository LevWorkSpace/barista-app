<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SetProductCode</fullName>
        <field>ProductCode__c</field>
        <formula>Name</formula>
        <name>SetProductCode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>IncorectProductCode</fullName>
        <actions>
            <name>SetProductCode</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>OR( 
						ISBLANK(ProductCode__c),
						ProductCode__c != Name
					)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
