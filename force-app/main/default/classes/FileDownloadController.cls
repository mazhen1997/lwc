public with sharing class FileDownloadController {

    public String documentId = '';

    public FileDownloadController() {
    List<Car__c> carlist = [select id,content__c,C_Formula_Field__c from Car__c];
    }

    public Boolean showDownload{get;set;}

    public FileDownloadController(ApexPages.StandardController controller) {
        init();
    }

    public void init() {
        Map<String,String> paramMap = ApexPages.currentPage().getParameters();
        if(paramMap.get('documentId') != null) {
            documentId = paramMap.get('documentId');
            showDownload = true;
        } else {
            showDownload = false;
        }
    }

    public String downloadURL{
        get {
            String urlBase = '/servlet/servlet.FileDownload?file=' + documentId;
            return urlBase;
        }
    }
}