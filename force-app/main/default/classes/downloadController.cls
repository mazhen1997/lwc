public class downloadController {
    
    public String message{ get;set;}
    public string listUrl{get;set;}
  /*
   * visual force page download
   * 

<apex:page action="{!initMethod}" standardController="T_henpinjyouhouitiran_sie__c" sidebar="false"
    showHeader="false" extensions="G45_T04_ProductReturnDownload" recordSetVar="list" lightningStylesheets="true"> 
    <head>
        <title>返品受付採番用データ</title>
        <meta name="referrer" content="no-referrer"/>
        <c:JqueryComponent />
        <apex:includeScript value="{!$Resource.jqmeter}" />
        <apex:includeScript value="{!$Resource.jsforce}" />
        <apex:stylesheet value="{!$Resource.salesforce_lightning}" />  
        <c:DownloadComponentPage />	
    </head>
    <body style="height:100%;display: flex;flex-direction: column;justify-content: center;align-item:center;">
        <div>
            <div style="font-size:16px;height:50px;text-align:center;line-height:50px">
                <span id="warn_msg"></span>
                <input class="btn" type="submit" value="閉じる" onclick="returnPage()" />
            </div>
            
           
            <div id='permissionErrorPrompt' class="demo-only" style="height: 24rem;display:none;">
                <section role="alertdialog" tabindex="-1" aria-labelledby="prompt-heading-id" aria-describedby="prompt-message-wrapper" class="slds-modal slds-fade-in-open slds-modal_prompt" aria-modal="true">
                    <div class="slds-modal__container">
                    <header class="slds-modal__header slds-theme_error slds-theme_alert-texture">
                        <button class="slds-button slds-button_icon slds-modal__close slds-button_icon-inverse" title="Close">
                        <svg class="slds-button__icon slds-button__icon_large" aria-hidden="true">
                            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/assets/icons/utility-sprite/svg/symbols.svg#close" />
                        </svg>
                        <span class="slds-assistive-text">Close</span>
                        </button>
                        <h2 class="slds-text-heading_medium" id="prompt-heading-id">エラーメッセージ</h2>
                    </header>
                    <div class="slds-modal__content slds-p-around_medium" id="prompt-message-wrapper">
                        <p>
                            {!message}
                        </p>
                    </div>
                    <footer class="slds-modal__footer slds-theme_default">
                        <button onclick="returnPage()" class="slds-button slds-button_neutral">確認</button>
                    </footer>
                    </div>
                </section>
                <div class="slds-backdrop slds-backdrop_open"></div>
            </div>

            <div id="jqmeter-container" style="margin:auto;width:40%"></div>
        </div>
        <div id="spreadsheet1"></div>
    </body>
      <script>
     //初始化查询导出数据
    //callProcess(0,1,200);
    console.log('start');
    var retJson = {!retJson};
    var orderProductList ;
    var referOrderProductList;
     if(retJson && retJson.status){
        orderProductList = retJson.orderProductList;
        //数据查询完毕，显示进度条
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '{!$Resource.G45_T04_ProductReturnDownload}', true);
        xhr.responseType = 'arraybuffer';
        xhr.onload = function (e) {
            var responseArray = new Uint8Array(this.response);
            $.ig.excel.Workbook.load(responseArray, function () {
                workbook = arguments[0];
                 setInitialSettings();
                // console.log('r-->'+success);
                //if (!success) {
                    console.log('hidden');
                    //$('#permissionErrorPrompt').show();
                // return;
                //}
                $("#warn_msg").html("ダウンロード中");
                name = retJson.fileName;
                workbook.save({ type: 'blob' }, function (data) {
                    saveAs(data, name);
                }, function (error) {
                    alert('Error exporting: : ' + error);
                });
                $("#warn_msg").html("ダウンロードが完了しました。ダイアログを閉じてください。");
            }, function () {
                console.log("fail");
            })
        };
        xhr.send();	
    }else{
    $('#permissionErrorPrompt').show();
    $('.btn').hide();
    }
    
        写入数据的方法
     
    function setInitialSettings() {
        console.log("set data");
        //if(retJson.productReturnJsonList.length == 0){
        //  return false;
        //}
      for(var i = 0 ; i < retJson.productReturnJsonList.length ; i++){
          var ws = workbook.worksheets("T04_返品受付採番用データ ");
          ws.getCell("B" + (i + 4)).value(retJson.productReturnJsonList[i].no);
          borderStyle(ws.getCell("B" + (i + 4)));
          backgroundStyle(ws.getCell("B" + (i + 4)));
          ws.getCell("C" + (i + 4)).value(retJson.productReturnJsonList[i].ukezukenodate);
          borderStyle(ws.getCell("C" + (i + 4)));
          ws.getCell("D" + (i + 4)).value(retJson.productReturnJsonList[i].productNo);
          borderStyle(ws.getCell("D" + (i + 4)));
          backgroundStyle(ws.getCell("D" + (i + 4)));
          ws.getCell("E" + (i + 4)).value(retJson.productReturnJsonList[i].ukezukeno);
          borderStyle(ws.getCell("E" + (i + 4)));
          ws.getCell("F" + (i + 4)).value(retJson.productReturnJsonList[i].tokuisakicode);
          borderStyle(ws.getCell("F" + (i + 4)));
          backgroundStyle(ws.getCell("F" + (i + 4)));
          ws.getCell("G" + (i + 4)).value(retJson.productReturnJsonList[i].customerinfoName);
          borderStyle(ws.getCell("G" + (i + 4)));
          backgroundStyle(ws.getCell("G" + (i + 4)));
          ws.getCell("H" + (i + 4)).value(retJson.productReturnJsonList[i].tokuisakitantousya);
          borderStyle(ws.getCell("H" + (i + 4)));
          backgroundStyle(ws.getCell("H" + (i + 4)));
          ws.getCell("I" + (i + 4)).value(retJson.productReturnJsonList[i].parent_child_id);
          borderStyle(ws.getCell("I" + (i + 4)));
          backgroundStyle(ws.getCell("I" + (i + 4)));
          ws.getCell("J" + (i + 4)).value(retJson.productReturnJsonList[i].parent_id);
          borderStyle(ws.getCell("J" + (i + 4)));
          backgroundStyle(ws.getCell("J" + (i + 4)));
          ws.getCell("K" + (i + 4)).value(retJson.productReturnJsonList[i].hinban);
          borderStyle(ws.getCell("K" + (i + 4)));
          backgroundStyle(ws.getCell("K" + (i + 4)));
          ws.getCell("L" + (i + 4)).value(retJson.productReturnJsonList[i].title);
          borderStyle(ws.getCell("L" + (i + 4)));
          backgroundStyle(ws.getCell("L" + (i + 4)));
          ws.getCell("M" + (i + 4)).value(retJson.productReturnJsonList[i].jan);
          borderStyle(ws.getCell("M" + (i + 4)));
          backgroundStyle(ws.getCell("M" + (i + 4)));
          ws.getCell("N" + (i + 4)).value(retJson.productReturnJsonList[i].suryou);
          borderStyle(ws.getCell("N" + (i + 4)));
          backgroundStyle(ws.getCell("N" + (i + 4)));
          ws.getCell("O" + (i + 4)).value(retJson.productReturnJsonList[i].kuremusyubetu);
          borderStyle(ws.getCell("O" + (i + 4)));
          backgroundStyle(ws.getCell("O" + (i + 4)));
      }
        var total =retJson.productReturnJsonList.length;
        callProcess(1,1,2500);
        //return true;
    
    };

       进度条方法
       
    function callProcess(current,total,speed){
        $('#jqmeter-container').jQMeter({
            goal:'$' + total,
            raised:'$' + current,
            orientation:'vertical',
            width:'100%',
            animationSpeed:speed,
            displayTotal:false,
            height:'50px'
        });
    }
    
    function borderStyle(ws){
        ws.cellFormat().bottomBorderStyle($.ig.excel.CellBorderLineStyle.thin);
        ws.cellFormat().leftBorderStyle($.ig.excel.CellBorderLineStyle.thin);
        ws.cellFormat().rightBorderStyle($.ig.excel.CellBorderLineStyle.thin);
        ws.cellFormat().topBorderStyle($.ig.excel.CellBorderLineStyle.thin);
    }
    function backgroundStyle(ws){
    ws.cellFormat().fill($.ig.excel.CellFill.createLinearGradientFill(45, '#D9D9D9', '#D9D9D9'))
    }
       
    function closePage(){
        var listUrl = '{!listUrl}';
        window.open(listUrl,'_top');
    }
    
    function returnPage(){
        window.history.back(-1); 
    }

    </script> 
</apex:page>

*/
    
   /*
    private  T_henpinjyouhouitiran_sie__c[] henpinjyouhouitiranArray;
    
    //返回信息
    @AuraEnabled
    public String retJson{set;get;}
    
    //sales refer Data
    @AuraEnabled	
    public String referData{set;get;}
    
    public G45_T04_ProductReturnDownload(ApexPages.StandardSetController getController){
        henpinjyouhouitiranArray=getController.getSelected();
    }
        
    public PageReference initMethod(){ 
        Schema.DescribeSObjectResult schemaResult = T_henpinjyouhouitiran_sie__c.SObjectType.getDescribe();
        listUrl = '/' + schemaResult.getKeyPrefix();
        ResultJson resultJ = new ResultJson();
        Id prodileId = UserInfo.getProfileId();
        List<profile> profiles = [select Id,Name from profile where Id = :prodileId];
        string profileName = '';
        if(profiles.size()>0){
            profile currentProfile = profiles[0];
            profileName = currentProfile.Name;
        }
        profile_settings__c psc = profile_settings__c.getInstance();
        if(profileName!=System.Label.system_manager_profile_name && profileName!=psc.ITS_MGR__c && profileName!=psc.application_pic__c){
            this.message = '該当ユーザーが「採番用ダウンロード」ボタン への利用権限がありません、オペレーション担当へ依頼お願いします。 ';
            retJson = JSON.serialize(resultJ);
            return null;
            
           }
        List<String> idList = new List<String>();
        if(henpinjyouhouitiranArray.size()>0){
            for(integer i=0; i<henpinjyouhouitiranArray.size();i++){
                idList.add(henpinjyouhouitiranArray.get(i).id);
            }
        }else if(henpinjyouhouitiranArray.size()== 0){
            this.message = '少なくとも一つの返品を選択してください。'; 
            retJson = JSON.serialize(resultJ);
            return null;
        }else if(henpinjyouhouitiranArray.size()>50){
            this.message = '一回で50件以内のレコードしかダウンロードできません。'; 
            retJson = JSON.serialize(resultJ);
            return null;
        }
        
        Integer i =1;
        List<AggregateResult> resultList =
            [select henpinno__r.Name,hinban__c,henpinno__r.customer_info_id__r.customer_id__c,title__c,genban_disp_hinban_jan__c,sum(suryou__c) from T_henpinjyouhousyousai_sie__c
             where  henpinno__r.henpinstatus__c = '03.承認済'  and henpinno__c in :idList
             group by henpinno__r.Name,hinban__c,henpinno__r.customer_info_id__r.customer_id__c,title__c,genban_disp_hinban_jan__c];
                    
        set<String> custormCode = new set<String>();
        if(resultList.size()>0){
            for(AggregateResult result :resultList){
                String code =(String)result.get('customer_id__c');
                custormCode.add(code);
            }
        }else if(resultList.size() == 0){
            this.message = '返品ステータスは\'承認済\'以外にの場合、ダウンロードできません'; 
            retJson = JSON.serialize(resultJ);
            return null;
        }
        List<customer_info__c> customerList = [select Name,territory__c,customer_id__c,parent_id__r.name,parent_child_id__c from customer_info__c where customer_id__c in :custormCode];
        
        List<ProductReturnJson> productReturnJsonsList = new List<ProductReturnJson>();
        
        for(AggregateResult result :resultList){
            ProductReturnJson productReturn = new  ProductReturnJson();
            if(resultList.size()>0){
                productReturn.no = String.valueOf(i);
                 i++;
            }
            //返品No
            productReturn.productNo = (String)result.get('Name');
            
            String resultcode = (String)result.get('customer_id__c');
            //得意先コード
             productReturn.tokuisakicode = resultcode;
             for(customer_info__c custorm :customerList){
                String custormInfocode = (String)custorm.customer_id__c;
                if(resultcode.equals(custormInfocode)){
                    //得意先名
                    productReturn.customerinfoName = (String)custorm.Name;
                    //得意先担当者
                    productReturn.tokuisakitantousya = (String)custorm.territory__c;
                    //集約店名
                    productReturn.parent_id = custorm.parent_id__r.name;
                    // 集約店ｺｰﾄﾞ
                    productReturn.parent_child_id = custorm.parent_child_id__c;
                }
            }
            
            //品番
            productReturn.hinban = (String)result.get('hinban__c');
            //タイトル
            productReturn.title = (String)result.get('title__c');
            //JAN
            productReturn.jan = (String)result.get('genban_disp_hinban_jan__c');
            //数量
            productReturn.suryou = (Double)result.get('expr0');
            //クレーム種別
            productReturn.kuremusyubetu = '01 不良・破損';
            
            productReturn.ukezukeno = ' ';
            
            productReturn.ukezukenodate = ' ';
            
            productReturnJsonsList.add(productReturn);
            
        }        
        
         Date d = Date.today();
         String year =String.valueOf(d.year());
         String month =String.valueOf(d.month());
         String day =String.valueOf(d.day());
        
         resultJ.status = true;
         resultJ.fileName = 'T04_返品受付採番用データ'+year+month+day+'.xlsx';
         resultJ.productReturnJsonList = productReturnJsonsList;
         //result.productReturnTitleJsonResult = productReturnTitleJson;
         retJson = JSON.serialize(resultJ);
         return null;

    }
    */
    
    //数据返回内部类    集合
    public class ProductReturnJson {

        @AuraEnabled
        public String no{get;set;}//NO        
        @AuraEnabled
        public String ukezukenodate {get;set;}//受付日付
        @AuraEnabled
        public String productNo{get;set;}//返品No.
        @AuraEnabled
        public String ukezukeno{get;set;}//受付No
        @AuraEnabled
        public String tokuisakicode{get;set;}//得意先コード
        @AuraEnabled
        public String customerinfoName{get;set;}//得意先名
        @AuraEnabled
        public String tokuisakitantousya{get;set;}//得意先担当者
        @AuraEnabled
        public String parent_id{get;set;}//集約店名
        @AuraEnabled
        public String parent_child_id{get;set;}//集約店ｺｰﾄﾞ
        @AuraEnabled
        public String hinban{get;set;}//品番 
        @AuraEnabled
        public String title{get;set;}//タイトル
        @AuraEnabled
        public String jan{get;set;}//JAN
        @AuraEnabled
        public Double suryou{get;set;}//数量
        @AuraEnabled
        public String kuremusyubetu{get;set;}//クレーム種別
        
    }
    
        //最终返回内部类
    public class ResultJson {
        
        @AuraEnabled
        public boolean status{get;set;}
        
        //下载文件模板名称
        @AuraEnabled
        public String fileName{get;set;}
        
        //下载文件模板名称
        @AuraEnabled
        public Date tenntyakubi{get;set;}
        
        //下载文件模板名称
        @AuraEnabled
        public Date warifuritsumiKigen{get;set;}
                    
        //下载数据list 
        @AuraEnabled
        public List<ProductReturnJson> productReturnJsonList{get;set;}
        
  
    }
    
    
    
    
    
    

}