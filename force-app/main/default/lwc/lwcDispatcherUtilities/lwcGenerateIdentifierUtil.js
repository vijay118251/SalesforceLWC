export default class LwcGenerateIdentifierUtil {
 static generateIdentifier(self,requestMethod,requestName) {
     return this['gen'+ requestName] (self,requestMethod);
 }
    static genAccountFire(self){
        return{
            accid: self.recordId
        };
    }
}