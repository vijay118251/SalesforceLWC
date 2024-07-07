/*
    Helper method for Javascript
*/
var consoleMessages=[];
var hasDebugPermission=true;
var hasConsoleDebugPermission=true;

// logging context
export const log = (...args) => {
    if(hasDebugPermission) {
        for(let arg of args) {
            console.log(arg);
            if(hasConsoleDebugPermission) {
                consoleMessages += arg + "\n\n";
            }
        }
        //console.log('consoleMessages'+consoleMessages);
    }
}

export const getConsoleMessages = () => {
    return consoleMessages;
}

//warn logging
export const warn = (...args) => {
    console.log(...args);
}

//error logging
export const error = (...args) => {
    console.log(...args);
}