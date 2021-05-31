import { LightningElement,api } from 'lwc';

export default class Augmentor extends LightningElement {
    startCounter = 0;
  
    handleStartChange(event) {
        console.log("*event-->*"+event.target.value)
      this.startCounter = parseInt(event.target.value);
    }
    handleMaximizeCounter() {
        this.startCounter=this.template.querySelector('c-numerator').maximizeCounter();
      }
      handleadd(){
          console.log('handleadd触发')
      }
}