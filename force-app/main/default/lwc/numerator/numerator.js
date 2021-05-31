import { LightningElement,api } from 'lwc';

export default class Numerator extends LightningElement {
    
  //counter = 0;
  _currentCount = 0;
  priorCount = 0;
  
  @api
  get counter() {
    console.log('get---->'+this._currentCount)
    return this._currentCount;
  }
  set counter(value) {
    console.log("set ----->value--->"+value)
    this.priorCount = this._currentCount;
    this._currentCount = value;
  }
  
    handleIncrement() {
      this.counter++;
      console.log("--我是父组件01，累加fun 调用成功 --");
    }
    handleDecrement() {
      this.counter--;
      console.log("--我是父组件02，递减fun 调用成功 --");
    }
    handleMultiply(event) {
      const factor = event.detail;
      this.counter *= factor;
    }

    @api
    maximizeCounter() {
      this.counter += 1000000;
      return this.counter;
    }


}