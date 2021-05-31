import { LightningElement } from 'lwc';

export default class Controls extends LightningElement {
  factors = [0,2,3,4,5,6];
    handleAdd() {
        this.dispatchEvent(new CustomEvent('add',{
          bubbles: true //冒泡传递   孙 传 爷
        }));
        console.log("**我是子组件01，添加自定义事件 add 完成**");
      }
      handleSubtract() {
        this.dispatchEvent(new CustomEvent('subtract',{
          bubbles: true //冒泡传递   孙 传 爷
        }));
        console.log("**我是子组件02，添加自定义事件 subtract 完成**");
      }

    handleMultiply(event) {
        const factor = event.target.dataset.factor;
        console.log("#####"+factor);
        this.dispatchEvent(new CustomEvent('multiply', {
          detail: factor,
          bubbles: true //冒泡传递   孙 传 爷
        }));
      }

}