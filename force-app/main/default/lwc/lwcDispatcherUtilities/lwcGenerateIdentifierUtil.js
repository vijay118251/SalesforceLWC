export default class LwcGenerateIdentifierUtil {
 static firstName='vijay';
 static generateIdentifier(self,requestMethod,requestName) {
     return this['gen'+ requestName] (self,requestMethod);
 }

    //generate accountId
    static genAccountFire(self){
        return{
            accid: self.recordId
        };
    }
}