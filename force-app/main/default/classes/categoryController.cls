public with sharing class categoryController {
    public categoryController() {

    }

    @AuraEnabled
    public static String getcategory(String type){
        if(type=='Sandwich' || type=='FrenchFries'){
            return 'Fast Food';
        } else if(type=='Chocolate' || type=='Blueberry'){
            return 'Juice';
        } else{
            return 'Cafe';
        }
            
        }
    }