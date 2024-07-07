import { LightningElement, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

export default class Example extends LightningElement {
  data;
  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  property;

  get recordTypeId() {
  this.data = this.property.data;
  console.log(JSON.stringify(this.data));
  }
}