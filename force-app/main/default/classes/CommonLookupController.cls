public  without sharing class CommonLookupController {

    @AuraEnabled
    public static List<sObject> fetchLookUpValues(String searchKeyWord, String objectName, Map<String,String> groupSelect,String additionalWhere) {
        List<sObject> returnList = new List<sObject> ();
        if(groupSelect.size() == 0){
            String searchKey = '%' + searchKeyWord + '%';
            String sQuery =  'select id, Name from ' + objectName + ' where Name LIKE: searchKey ' + additionalWhere + ' order by createdDate DESC limit 5';
            List <sObject> lstOfRecords = Database.query(sQuery);
            for (sObject obj: lstOfRecords) {
                returnList.add(obj);
            }
        }else{
            String groupId = groupSelect.get('Id');
            String groupName = groupSelect.get('Name');
            String searchKey = '%' + searchKeyWord + '%';
            String sQuerys =  'select ' + groupId  + ',' + groupName + ' from ' + objectName  + ' where ' + groupName + ' LIKE \'' + searchKey + '\' GROUP BY ' + groupId + ',' + groupName + ' limit 5';
            System.debug(sQuerys);
            List <sObject> lstOfRecords = Database.query(sQuerys);
            for (sObject obj: lstOfRecords) {
                returnList.add(obj);
            }
        }
        return returnList;
    }
    
    @AuraEnabled
    public static List<sObject> initialFetchLookUpValues(String initialQueryId, String objectName) {
        String sQuery =  'select id, Name from ' + objectName + ' where Id = :initialQueryId';
        List <sObject> lstOfRecords = Database.query(sQuery);
        return lstOfRecords;
    }
}