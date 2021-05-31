import { LightningElement,api } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import myStaticStyles from '@salesforce/resourceUrl/lightningstyle'

export default class FileUploadExample extends LightningElement {
    @api
    myRecordId
    connectedCallback() {
        console.log('init');
        //Promise.all([loadStyle(this, myStaticStyles)]);
       /*  const isMediumDev = (window.matchMedia("(min-width: 768px)").matches);
        if(isMediumDev){
            document.getElementsByClassName('c-container').style.display='block';
        }
        */
    }
    get acceptedFormats(){
        return ['.pdf','.png','jpg'];
    }
    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        console.log("No. of files uploaded : " + uploadedFiles.length);
    }
    handleChange(){
        console.log('------');
    }
  /**
   * Small Deviceであるか
   * ・Breakpoint Width：～768px(48em)
   */

}