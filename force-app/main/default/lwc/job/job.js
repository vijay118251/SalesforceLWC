import { ReduxElement } from 'c/lwcRedux';
import {entry, mid, expert} from 'c/jobActions';
export default class Job extends ReduxElement {
    mapStateToProps(state){
        console.log('mapStateToProps',JSON.parse(JSON.stringify(state)));
        return {counter: state.counter, joblevel: state.joblevel};
    }
    mapDispatchToProps(){
        console.log('mapDispatchToProps');
        return { entry, mid, expert};
    }
}