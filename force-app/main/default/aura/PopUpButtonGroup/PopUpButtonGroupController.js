({
	doInit : function(component, event, helper) {
        
        var action = component.get("c.getImages");
        action.setParams({
            "recordId": component.get("v.Id")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                console.log("success");
                component.set("v.items", response.getReturnValue());
                
            }else{
                console.log("error");
            }
        });
        
        $A.enqueueAction(action);
        

    },
    openInit : function(component, event, helper){
        var  downloadframe = component.find("myIframe").getElement();
        component.set("v.dialogOpen",true);
        //var recordId = component.get("v.recordId");
        //setTimeout(function(){
            downloadframe.src=location.origin+"/apex/upload?recordId="+123;
        //},50);
    },
    dialogClose :function(component, event, helper){
        
    },
    startOpten :function(component, event, helper) {
		 component.set("v.dialogCustormOpen",true);
	},
    importf :function(component, event, helper,obj){
        console.log("obj"+obj);
        var rABS = false;
        var sheets = "T04_返品受付採番用データ ";
        var keyList = [];
        var cellDataListMap = [];
        //数据行位置
        var theDataLine = 1;
        if(obj.files.length == 0) {
            toggleMask(false);
            templateError(true);
            return;
        }
        var f = obj.files[0];
        var reader = new FileReader();
        reader.onload = function(e) {
            setTimeout(function(){
                inputFileOnLoad(component, event, helper,e)
            },100);
        };
        if(rABS) {
            reader.readAsArrayBuffer(f);
        } else {
            reader.readAsBinaryString(f);
        }
    },
    inputFileOnLoad :function(component, event, helper,e){
          try{
            var fileName = $("#file-upload-input-01").val();
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
            parseData(component, event, helper,cellDataList);
        }catch(e){
            templateError(true);
            toggleMask(false);
            return;
        }
    },
    parseData :function(component, event, helper,cellDataList){
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
        console.log("cellDataListMap"+cellDataListMap);
        addDataTr(component, event, helper,cellDataListMap);
        console.log("end");
    },
    addDataTr :function(component, event, helper,cellDataListMap){
           var data ="";
        for(var i = 0 ; i < cellDataListMap.length ; i++){
            var appendDataTr = "";
            for(var y = 0 ; y < keyList.length ; y++){
                var onOff = false;
                if(cellDataListMap[i][keyList[y]] != undefined){    
                    appendDataTr = appendDataTr + "<td data-label=\"\"> <div class=\"slds-truncate\" title=\"\">"+cellDataListMap[i][keyList[y]]+"</div></td>";
                    console.log("appendDataTr->"+appendDataTr);
                }else{
                    appendDataTr = appendDataTr + "<td data-label=\"\"> <div class=\"slds-truncate\" title=\"\"></div></td>";
                }
            }
            data ="<tr class=\"slds-hint-parent\" >"+appendDataTr+"</tr>";
            $("#showDataTable").append("<tbody>"+data+"</tbody>");
        }     
    },
    onbuler :function(componment,event,helper){
        //var bb=componment.get("v.firstName");
        //console.log(bb);
          	var cc=componment.get("v.entity");
        //console.log(cc.Name);
        
        helper.helperMethod(componment,event);
        
    },
      previewFile :function(componment,event,helper){
          console.log("111");
         var selectedPillId = event.getSource().get("v.name");
          console.log(selectedPillId);
        
          $A.get('e.lightning:openFiles').fire({
		    recordIds: [selectedPillId]
		});

    }

 
})