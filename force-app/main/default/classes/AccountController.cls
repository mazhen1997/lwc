public with sharing class AccountController {
   @AuraEnabled
  public static List<Account> getBooks(Integer limits , Integer offsets) {
 
        System.debug('limits'+limits);

        System.debug('offsets'+offsets);

        Integer intlimits = integer.valueof(limits);

        Integer intoffsets = integer.valueof(offsets);

     List<Account> i=[SELECT Id,Name,Active__c FROM Account Limit :intlimits Offset :intoffsets ];
        return i;
  }
    @AuraEnabled
    public static Integer getTotalCount(){
        AggregateResult results = [select  count(Id) total  from Account ];

        Integer total =(Integer)results.get('total') ;

        return total;

    }
    
    @AuraEnabled
     public static List < Account > fetchAccts(Integer intOffSet) {
        
        return [ SELECT Id, Name, Industry, Type FROM Account LIMIT 5 OFFSET : Integer.valueOf(intOffSet) ];
        
    }
    
     //Get Contact List
    @AuraEnabled
    public static List<Contact> getContactList(Integer recordLimit, Integer recordOffset){
        Integer intLimit = Integer.valueof(recordLimit);
        Integer intOffset = Integer.valueof(recordOffset);
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id, Name, Email, Phone FROM Contact LIMIT :intLimit Offset :intOffset];
        return conList;
    }
    
    //Get Total Number of Contacts
    @AuraEnabled
    public static Integer getTotalContacts(){
        AggregateResult results = [SELECT Count(Id) TotalContacts  From Contact];
        Integer totalContacts = (Integer)results.get('TotalContacts') ; 
        return totalContacts;
    } 
    
    //Delete Contact
    @AuraEnabled
    public static void deleteContact(Contact con){
        Delete con;
    } 


}