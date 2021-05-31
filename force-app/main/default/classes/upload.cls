public class upload {
    /*
     * visualforce page upload*
     <apex:page Controller="G45_T04_ProductReturnUpload" sidebar="false" showHeader="false" lightningStylesheets="true">
    <head>
        <meta charset="UTF-8"/>
        <title></title>
        <apex:includeScript value="{!$Resource.jquery}" />
        <apex:includeScript value="{!$Resource.sheetJs}" />
    </head>
    <body>
        <div style="font-size:1rem;line-height:3rem;text-align:center;">
            <span id="warn_msg" style="color:#16325C;" ></span>
              <input class="btn" type="submit" value="閉じる" onclick="getApexlistUrl()" style="display:none" />
        </div>
        <div id="head"  style="margin-top: 1rem;display:none;">
            <div id="templateError" style="display:none;" >
                <p style="font-size:1rem;color:#16325C; text-align:center;" >解析が失敗しました。エクセルテンプレートが変更されている可能性があります。</p>
            </div>
            <div style="height:5px"></div>
            <a href="javascript:;" class="file">ファイルを選択
                <input type="file" id="excelUpload" onchange="importf(this);" style="width:50%;" accept=".xls,.xlsx"/>
            </a>
            <a href="javascript:;" class="file" onclick="confirm_import();">導入を確認する
                <input id="confirm_import" type="button" value=""/>                    
            </a>
            <div style="height:10px"></div>
            <div id="mask" style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;z-index:100;background:rgba(8, 7, 7, 0.6);display:none;" >
                <div style="padding-top:50px;text-align:center;height:100%;">
                    <img src="{!$Resource.loadgif}" width="50px" height="50px"/>
                    <span style="font-size:1.5rem;color:white;" >excelデータ解析中</span>
                </div>
            </div>
            <div id="demo"> 
                <span id="productMsg"></span>
                <table class="gridtable" id="showDataTable" style="border: solid 1.5px #19afe6; width:100%" border="0" cellpadding="0" cellspacing="0"> 
                    <tr id="showDataTableKey">
                        <td class="basicsStyleTd" value="No">
                            No.
                        </td>
                        <td class="basicsStyleTd" value="ukezukenodate">
                            受付日付
                        </td>
                        <td class="basicsStyleTd" value="productNo">
                            返品No.
                        </td>
                        <td class="basicsStyleTd" value="ukezukeno">
                            受付No.
                        </td>
                        <td class="basicsStyleTd" value="tokuisakicode">
                            得意先コード
                        </td>
                        <td class="basicsStyleTd" value="customerinfoName">
                            得意先名
                        </td>
                        <td class="basicsStyleTd" value="tokuisakitantousya">
                            得意先担当者
                        </td>
                        <td class="basicsStyleTd" value="parent_id">
                            集約店コード
                        </td>
                        <td class="basicsStyleTd" value="parent_child_id">
                            集約店名
                        </td>
                        <td class="basicsStyleTd" value="hinban">
                            記号番号                        
                        </td>
                        <td class="basicsStyleTd" value="title">
                            タイトル
                        </td>
                        <td class="basicsStyleTd" value="jan">
                            JAN
                        </td>
                        <td class="basicsStyleTd" value="suryou">
                            返品数
                        </td>
                        <td class="basicsStyleTd" value="kuremusyubetu">
                            クレーム種別
                        </td>
                    </tr>
                </table>    
            </div>
        </div>
    </body>
    <script>
    
    $(window).load(function() { 
        Visualforce.remoting.Manager.invokeAction(
            '{!$RemoteAction.G45_T04_ProductReturnUpload.getProfile}',
            function(result, event){
                if (event.status) {
                    // UploadSuccess(true);
                    console.log("success");
                    if(Boolean(result)){
                        headSuccess(true);
                       
                    }else{
                         $('#warn_msg').html("該当ユーザーが「採番用データアップロード」ボタン への利用権限がありません、オペレーション担当へ依頼お願いします。 ");
                         $(".btn").css('display','inline'); 
                    }
                    
                } else if (event.type === 'exception') { 
                    console.log("exception");
                } else {
                    console.log("else");
                }
            }, 
            {escape: true}
        );
    });    
    var rABS = false;
    var sheets = "T04_返品受付採番用データ ";
    var keyList = [];
    var cellDataListMap = [];
    //数据行位置
    var theDataLine = 1;
    
    window.onload = function(){
        toggleMask(false);
        var showDataTableKey = $("#showDataTableKey").find("td");
        for(var i = 0 ; i < showDataTableKey.length; i++){
            keyList[i] = $.trim($(showDataTableKey[i]).attr("value"));
        }
        
    }
    
    function importf(obj) {
        toggleMask(true);
        if(obj.files.length == 0) {
            toggleMask(false);
            templateError(true);
            return;
        }
        var f = obj.files[0];
        var reader = new FileReader();
        reader.onload = function(e) {
            setTimeout(function(){
                inputFileOnLoad(e)
            },100);
        };
        if(rABS) {
            reader.readAsArrayBuffer(f);
        } else {
            reader.readAsBinaryString(f);
        }
    }
    
    function inputFileOnLoad(e){
        try{
            var fileName = $("#excelUpload").val();
            var fileExt = fileName.substring(fileName.lastIndexOf("."));
            if(fileExt != ".xls" && fileExt!=".xlsx"){
                console.log("suffix error");   
            } 
            var data = e.target.result;
            if(rABS) {
                wb = XLSX.read(btoa(fixdata(data)), {
                    type: 'base64'
                });
            } else {
                wb = XLSX.read(data, {
                    type: 'binary'
                });
            }
            var cellDataList = XLSX.utils.sheet_to_json(wb.Sheets[sheets]);
            //数据行位置
            console.log(cellDataList); 
            cellDataList = cellDataList.slice(theDataLine,cellDataList.length)
            //检测excel
            if(cellDataList.length < 1){
                toggleMask(false);
                templateError(true);
                return;
            }
            parseData(cellDataList);
        }catch(e){
            templateError(true);
            toggleMask(false);
            return;
        }
    }
    
    function parseData(cellDataList){
        //解析excel
        for(var i = 0 ; i < cellDataList.length ; i++){
            var myMap = {};
            for(y in keyList){
                if(y == 0){
                    if(cellDataList[i]['__EMPTY'] != undefined){
                        myMap[keyList[0]] = cellDataList[i]['__EMPTY'];                    
                    }
                }else{
                    if(cellDataList[i]['__EMPTY_' + y] != undefined){
                        myMap[keyList[y]] = cellDataList[i]['__EMPTY_' + y];                            
                    }
                }
            };
            //excel校验
            myMap.ukezukenodate = formatDate(myMap.ukezukenodate);
            
            cellDataListMap[i] = myMap;
        }
        addDataTr(cellDataListMap);
        toggleMask(false);
    }
    
    function confirm_import(){
        callApex()
    }       
    
    
    function callApex(){
        if(cellDataListMap.length>0){
            Visualforce.remoting.Manager.invokeAction(
                '{!$RemoteAction.G45_T04_ProductReturnUpload.upload}',
                cellDataListMap,
                function(result, event){
                    if (event.status) {
                        // UploadSuccess(true);
                      $('#warn_msg').html(result);
                        console.log("success");
                    } else if (event.type === 'exception') { 
                        console.log("exception");
                    } else {
                        console.log("else");
                    }
                }, 
                {escape: true}
            );
        }
    }    
   
    function getApexlistUrl(){
            Visualforce.remoting.Manager.invokeAction(
                '{!$RemoteAction.G45_T04_ProductReturnUpload.getListUrl}',
                function(result, event){
                    if (event.status) {
                        var listUrl = result;
                        window.open(listUrl,'_top');
                    } else if (event.type === 'exception') { 
                        console.log("exception");
                    } else {
                        console.log("else");
                    }
                }, 
                {escape: true}
            );
        }

 
    function toggleMask(show){
        var mask = $("#mask");
        show?mask.show():mask.hide();
    }
    
    function templateError(show){
        var mask = document.getElementById("templateError");
        mask.style.display=show?"block":"none";
    }
    function headSuccess(show){
        var mask = document.getElementById("head");
        mask.style.display=show?"block":"none";
    }
    function UploadSuccess(show){
        var mask = document.getElementById("UploadSuccess");
        mask.style.display=show?"block":"none";
     }
    
    //插入table
    function addDataTr(cellDataListMap){
        for(var i = 0 ; i < cellDataListMap.length ; i++){
            var appendDataTr = "";
            for(var y = 0 ; y < keyList.length ; y++){
                var onOff = false;
                if(cellDataListMap[i][keyList[y]] != undefined){
                    appendDataTr = appendDataTr + "<td class=\"basicsStyleTd\">"+cellDataListMap[i][keyList[y]]+"</td>";
                }else{
                    appendDataTr = appendDataTr + "<td class=\"basicsStyleTd\"></td>"
                }
                
            }
            
            $("#showDataTable").append("<tr class=\"\" >"+appendDataTr+"</tr>");
        }
    }
        function formatDate(numb) {
        if(numb != '' && numb != undefined){
            const time = new Date((numb - 1) * 24 * 3600000 + 1);
            time.setYear(time.getFullYear() - 70);
            const year = time.getFullYear() + '';
            const month = time.getMonth() + 1 + '';
            const date = time.getDate()+ '';
            const hours = time.getHours() + '';
            const minutes = time.getMinutes() + '';
            return year + "-" + (month < 10 ? '0' + month : month) + "-" + (date < 10 ? '0' + date : date)// + " " +(hours < 10 ? '0' + hours : hours) + ":" + (minutes < 10 ? '0' + minutes : minutes)
        }else{
            return "";
        }
    }
    
    </script>
    <style>
        .displayMessage{
        display:display;
        }
        
        .basicsStyleTd{
        height: 2.5rem;
        border: solid 1px #000000;
        text-align: center;
        vertical-align: middle;    
        font-size: 1rem;
        color: #6e6e6e;
        }
        
        .file {
        position: relative;
        display: inline-block;
        background: #D0EEFF;
        border: 1px solid #99D3F5;
        border-radius: 4px;
        padding: 4px 12px;
        overflow: hidden;
        color: #1E88C7;
        text-decoration: none;
        text-indent: 0;
        line-height: 20px;
        text-align: center;
        width:12%;
        }
        .file input {
        position: absolute;
        font-size: 5rem;
        right: 0;
        top: 0;
        opacity: 0;
        }
        .file:hover {
        background: #AADFFD;
        border-color: #78C3F3;
        color: #004974;
        text-decoration: none;
        }
    </style>

   */

    /*
     * 
     * global without sharing  class G45_T04_ProductReturnUpload {
    
    @RemoteAction
    global static String  upload(List<Map<String,Object>> productList){
        
        Set<String> productNoSet = new Set<String>();
        String message = '';
        for(Map<String,Object> productMap : productList){
            String productNo =(String)productMap.get('productNo');
            productNoSet.add(productNo);      
        }
        List<T_henpinjyouhouitiran_sie__c> resultList = [select id,Name,ukezukeno__c,uketsuke_date__c,henpinstatus__c,comment__c from T_henpinjyouhouitiran_sie__c where Name in :productNoSet ];
        if(resultList.size()>0){
            List<T_henpinjyouhouitiran_sie__c> updateProductList = new List<T_henpinjyouhouitiran_sie__c>();
            for(Map<String,Object> productMap : productList){
                T_henpinjyouhouitiran_sie__c henpin = new T_henpinjyouhouitiran_sie__c();
                for(T_henpinjyouhouitiran_sie__c product:resultList){
                    String productNo = String.valueOf(productMap.get('productNo'));
                    String name = (String)product.Name;
                    String ukezukenodate = (String)productMap.get('ukezukenodate');
                    if(productNo.equals(name)){
                        product.ukezukeno__c = String.valueOf(productMap.get('ukezukeno'));
                        product.uketsuke_date__c = Date.valueOf(ukezukenodate);
                        product.henpinstatus__c = '05.受付済';
                        product.comment__c = '該当返品が受付済みになりました。';
                    }
                }
            }
            update resultList;
            updateProductContact(productList);
            message= 'アップロードが完了しました。ダイアログを閉じてください。';
            
        }
        return message;
    }
    
    private static void updateProductContact(List<Map<String,Object>> paramList){
        
        Set<String> productNoSet = new Set<String>();
        for(Map<String,Object> productMap : paramList){
            String productNo =(String)productMap.get('productNo');
            productNoSet.add(productNo);      
        }
        List<T_henpinrenrakuhyou__c> productContactList = [select id,henpinno__c,henpinstatus__c,comment__c from T_henpinrenrakuhyou__c where henpinno__c in :productNoSet ];
        List<T_henpinjyouhouitiran_sie__c> productList = [select id,Name,ukezukeno__c,uketsuke_date__c,henpinstatus__c,comment__c from T_henpinjyouhouitiran_sie__c where Name in :productNoSet ];
        for(T_henpinrenrakuhyou__c productContact:productContactList){
            for(T_henpinjyouhouitiran_sie__c product: productList){
                String name = (String)product.Name;
                String henpinno = (String)productContact.henpinno__c;
                String ukezukeno = (String)product.ukezukeno__c;
                if(henpinno.equals(name) && ukezukeno !=null ){
                    productContact.uketukeno__c = ukezukeno;
                    productContact.henpinstatus__c = '05.受付済';
                    //henpinrenrakuhyou.uketsuke_date__c = (Date)henpinjyouhouitiran.uketsuke_date__c; 04.却下
                    productContact.comment__c = '該当返品が受付済になりました。';
                }
            }
        }
        update productContactList;
        
    }
    @RemoteAction
    global static Boolean getProfile(){
        Id prodileId = UserInfo.getProfileId();
        List<profile> profiles = [select Id,Name from profile where Id = :prodileId];
        string profileName = '';
        if(profiles.size()>0){
            profile currentProfile = profiles[0];
            profileName = currentProfile.Name;
        }
        profile_settings__c psc = profile_settings__c.getInstance();
        if(profileName!=System.Label.system_manager_profile_name && profileName!=psc.ITS_MGR__c && profileName!=psc.application_pic__c){
            return false;
        }
        return true;
    }
    
    @RemoteAction
    global static String getListUrl(){
        Schema.DescribeSObjectResult schemaResult = T_henpinjyouhouitiran_sie__c.SObjectType.getDescribe();
        String listUrl = '/' + schemaResult.getKeyPrefix();
        return listUrl;
    }
    
   
    
    */
    
    
       
    

}