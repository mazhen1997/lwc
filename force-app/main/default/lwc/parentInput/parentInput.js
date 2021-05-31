import {LightningElement } from 'lwc';

export default class ParentInput extends LightningElement {
    startCounter=0;
    handleStartChange(event){
        this.startCounter = parseInt(event.target.value);
    }
    handlechildChange(event){
        this.startCounter = parseInt(event.target.value);

    }
}