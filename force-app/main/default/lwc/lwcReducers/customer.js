const initialState = {
    "customerData" : {
        firstName:'',
        lastName:'',
        company:'',
        jobTitle:''
    }
};

export const customer = (state = initialState, action) => {
    switch (action.type) {
       case "CUST_DETAILS": 
        return action.payload;
       default: 
        return state;
    }
}