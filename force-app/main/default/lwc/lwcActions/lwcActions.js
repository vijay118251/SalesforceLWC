export const getCustomerDetails = (customerData) => {
    return {
        type:'CUST_DETAILS',
        payload:customerData
    };
};


export const fireCustomer = (showCustomer) => {
    return {
        type:'SHOW_CUST',
        payload:showCustomer
    };
}