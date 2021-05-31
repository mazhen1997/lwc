import { LightningElement } from 'lwc';

export default class Hellolwc extends LightningElement {
    greeting = 'World';
    changeHandler(event) {
      this.greeting = event.target.value;
    }
}