import { LightningElement, api } from 'lwc';
import {createStore, combineReducers} from 'c/lwcRedux';
import reducers from 'c/jobReducers';
export default class JobContainer extends LightningElement {
    @api store;
    initialize(){
        console.log('Initialize');
        const combineReducersInstance = combineReducers(reducers);
        console.log(combineReducersInstance);
        this.store = createStore(combineReducersInstance);
        console.log(this.store);
    }
}