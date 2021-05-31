import { LightningElement,api } from 'lwc';

export default class ChildInput extends LightningElement {
    @api
    counter=0;

    handlechildChange(event){
    }
}