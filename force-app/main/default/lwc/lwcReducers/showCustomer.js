const initialState = {};

export const showCustomer = (state = initialState, action) => {
    switch (action.type) {
       case "SHOW_CUST": 
        return action.payload;
       default: 
        return state;
    }
}