public with sharing class ContactController {
    @AuraEnabled(cacheable='true')
    public static List<Contact> getContacts(){
        try {
            return [select  firstname,lastname,email from contact];    
        } catch (Exception e) {
            throw new AuraHandledException('Forced error');
        }
    }
}