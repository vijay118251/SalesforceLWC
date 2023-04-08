//Coverting Date format
const convertDate = dateFormat => {
    let date = new Date(dateFormat);
    let m = (date.getMonth() + 1);
    let d = (date.getDate());
    return date.getFullYear() + '-' + (m <= 9 ? '0' + m : m) + '-' + (d <= 9 ? '0' + d : d);
};

export {
    convertDate
};