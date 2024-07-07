public class CollectionsPractice {
    public void ListPractice(){
        List<String> stringList = new List<String>();
        //adding through Add method
        stringList.Add('hi');
        stringList.Add('hello');
        System.debug('stringList-->'+stringList);
        List<String> stringList2 = new List<String> {'how','are','you','da'};
        System.debug('stringList2-->'+stringList2);
        //accessing the elements through index
        System.debug('element at index 2-->'+stringList2[2]);
        //accessing the elements through get method
        System.debug('element at index 2 through get-->'+stringList2.get(2));
        //adding parameters at particular index through add method
        stringList2.add(3,'idiot');
        System.debug('stringList2 after adding at 3rd index-->'+stringList2);
        //removing the element at particular index using remove method
        stringList2.remove(3); //remove method takes the index as parameter
        System.debug('stringList2 after removing the 3rd index-->'+stringList2);
        //other common methods in Lists
        stringList.clear();
        System.debug('stringList cleared-->'+stringList); // clears the list
        System.debug('isEmpty without elements-->'+stringList.isEmpty()); //returns true if list is empty
        System.debug('isEmpty with elements-->'+stringList2.isEmpty()); //returns true if list is empty
        System.debug('Size of list2-->'+stringList2.size()); // returns the size of the list
        System.debug('is da contains in list2-->'+stringList2.contains('da')); // returns true if the element is present in list
        stringList2.sort();
        System.debug('sorting a list-->'+stringList2); // sorts a list
    }
    
    public void SetPractice(){
        Set<Integer> numbers = new Set<Integer>{1,2,3,4,5}; // initializing a set
        System.debug('numbers-->'+numbers);
        Set<String> names = new Set<String>();
        //adding elements through add method
        names.add('Deepika');
        names.add('shobha');
        names.add('Kusuma');
        
        List<String> namesList = new List<String>{'Raji','Leela','Vyshu'};
        System.debug('names-->'+names);
        //passing a list to addAll method
        names.addAll(namesList); // we can pass either list or set to addAll method
        System.debug('after adding a list through addAll-->'+names);
        Boolean b = names.contains('shobha'); //returns true if the set contains a value
        System.debug('is it contains shobha? '+b);
        System.debug('is it contains nani? '+names.contains('nani'));
        System.debug('is it contains namesList? '+names.containsAll(namesList)); // we can pass either list or set to containsAll
        //check if 2 sets are equal or not through equals method-- it returns boolean value
        System.debug('names and namesList are equal ?'+names.equals(namesList));
        System.debug('check if names is empty '+names.isEmpty()); // returns boolean value
        //removing an element from Set
        names.remove('Deepika');
        System.debug('names after removing deepika '+names);
        //removing an elements through removeAll method
        names.removeAll(namesList); // we can pass either list or set to removeAll method
        System.debug('names after removing namesList-->'+names);
        System.debug('namesList-->'+namesList);
        names.add('Leela');
        //retaing the removed elements through retainAll method
        names.retainAll(namesList); // we can pass either list or set as parameter
        System.debug('names after retaining namesList-->'+names);
        System.debug('size of names->'+names.size());
    }
    
    //Map practice
    public void MapPractice() {
        Map<Integer,String> names = new Map<Integer,string>();
        names.put(1,'Deepika');
        names.put(2,'Vijay');
        names.put(3,'Deepu');
        names.put(4,'Viju');
        System.debug('namesMap-->'+names);
        //assigning values through direct initialisation
        Map<String,Object> colleges = new Map<String,Object>{'Deepu'=>8,'Viju'=>9};
        System.debug('collegesMap-->'+colleges);
        System.debug('keyset of names maps-->' + names.KeySet());
        System.debug('colleges keyset-->'+colleges.KeySet());
        System.debug('valueset of names maps-->' + names.Values());
        System.debug('colleges valueset-->'+colleges.Values());
        System.debug('is colleges contains IIIT ? '+colleges.containsKey('Deepu'));
        System.debug('is colleges contains Satyabhama ? '+colleges.containsKey('Satyabhama'));
        //System.debug('is colleges contains IIIT ? '+colleges.containsValue('Deepu'));
        //System.debug('is colleges contains Satyabhama ? '+colleges.containsValue('Viju'));
        System.debug('get the value of 4 from names-->'+names.get(4));
        System.debug('get the value of Viju from colleges-->'+colleges.get('Viju'));
        System.debug('is names empty ? '+names.isEmpty());
        //converting acc list to map
        List<Account> accList = [SELECT Id,Name From Account Limit 10];
        System.debug('accList-->'+accList);
        Map<Id,Account> accMap = new Map<Id,Account>(accList);
        System.debug('accMap-->'+accMap);
        Map<Id,Account> accMap2 = new Map<Id,Account> ([SELECT Id,Name FROM Account Limit 5]);
        System.debug('accMap2-->'+accMap2);
        
    }
    
    public void showRelatedContacts(){
        Map<Id,Map<Id,Contact>> finalMap = new Map<Id,Map<Id,Contact>>();
        List<Account> accounts = [SELECT Id, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account LIMIT 5];
        for(Account acc : accounts){
            Map<Id,Contact> contactMap = new Map<Id,Contact>();
            for(Contact con : acc.Contacts){
                contactMap.put(con.Id, con);
            }
            finalMap.put(acc.Id,contactMap);
        } 
        System.debug('finalMap-->'+finalMap);
    }
}