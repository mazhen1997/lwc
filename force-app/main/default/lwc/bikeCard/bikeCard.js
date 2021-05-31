import { LightningElement,wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';//?
import Id from '@salesforce/user/Id';
import  NAME_FIELD from '@salesforce/schema/User.Name';
const fields = [ NAME_FIELD];
const uid =[Id];
console.log("uid----->:"+uid)
//console.log("fields----->:"+fields[0])
export default class BikeCard extends LightningElement {
    name = 'Electra X4';
    description = 'A sweet bike built for comfort.';
    category = 'Mountain';
    material = 'Steel';
    price = '$2,700';
    pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';
    userId = Id;
    @wire(getRecord, { recordId: '$userId', fields }) 
    user;
    get username() {
       //console.log("userId----->:"+uid)
       // console.log("fields----->:"+fields)
        return getFieldValue(this.user.data, NAME_FIELD);
    }
}