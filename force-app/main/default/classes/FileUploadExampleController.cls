public with sharing class FileUploadExampleController {
    public FileUploadExampleController() {

    }

    /**
     * @description ファイルアップロード
     * @param idParent 関連先ID
     * @param strFileName ファイル名
     * @param base64Data ファイル
     * @return ファイルのContentVersion
     */
    @AuraEnabled
    public static ContentVersion saveFile(Id idParent, String strFileName, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');

        ContentVersion cv = new ContentVersion();
        cv.Title = strFileName;
        cv.PathOnClient = '/' + strFileName;
        cv.FirstPublishLocationId = idParent;
        cv.VersionData = EncodingUtil.base64Decode(base64Data);
        cv.IsMajorVersion = true;
        insert cv;

        Map<Id, ContentVersion> cvMap = new Map<Id, ContentVersion>([
            SELECT
                Id,
                Title,
                ContentDocumentId,
                FirstPublishLocationId
            FROM
                ContentVersion
            WHERE
                Id = :cv.Id
        ]);

        return cvMap.values()[0];
    }
}