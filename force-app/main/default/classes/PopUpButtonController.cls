public with sharing class PopUpButtonController {
    @AuraEnabled 
    public static  String getParams(Contact name){
        System.debug('params->:'+name);
        return '传值调用成功';
    }
    @AuraEnabled 
      public static List<ContentVersion> getImages(String recordId){
          List<ContentVersion> contentDocumentLink=
              [SELECT Id, Title, FileExtension, ContentDocumentId From ContentVersion limit 1];
          return contentDocumentLink ;
      }
    
}