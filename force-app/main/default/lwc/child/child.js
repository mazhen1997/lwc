import { LightningElement,api } from 'lwc';

export default class Child extends LightningElement {
    @api
    counter=0;

    handlechildChange(event){
        this.dispatchEvent(new CustomEvent("childchange"));
    }
}