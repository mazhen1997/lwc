public with sharing class FileUploadUsedTransientController {

    public transient Blob fileUploadBody{get;set;}

    public String fileUploadName{get;set;}

    public void uploadFile() {
        Document uploadFileDocument = new Document();
        Boolean needInsert = false;
        if(fileUploadBody != null && fileUploadBody.size() > 0) {
            uploadFileDocument.body = fileUploadBody;
            needInsert = true;
        }
        if(fileUploadName != null) {
            uploadFileDocument.Name = fileUploadName;
            needInsert = true;
        }

        if(needInsert) {
            try {
               	uploadFileDocument.FolderId = '0052v00000azwmIAAQ';  // 用户ID 
                insert uploadFileDocument;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO,'上传成功'));
            } catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'上传失败'));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING,'无上传内容'));
        }
    }
    


}