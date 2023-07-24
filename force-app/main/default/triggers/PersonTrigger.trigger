trigger PersonTrigger on Person__c (before insert, after insert,after update, after delete, after undelete) {
 switch on Trigger.OperationType {
  when BEFORE_INSERT {
    for(Person__c person : Trigger.new){
      if (person.Health_Status__c != 'Green' && String.isNotBlank(person.Mobile__c)){
        person.addError('You can not save a Person Object with the Health Status other than Green! ');
      }
      if (String.isNotBlank(person.Mobile__c)){
        person.addError('You Mobile field can not be blank! ');
      }
    }
  }
  when AFTER_INSERT {
    List <Person__c> personList = new  List <Person__c>(); 
    for(Person__c person : Trigger.new){
        Blob value = Blob.valueOf(person.Mobile__c);
        Blob hash = Crypto.generateDigest('MD5', value);
        person.Token__c = EncodingUtil.base64Encode(hash);
        personList.add(person);
    }
    update personList;
  }
  when AFTER_UPDATE {
    List <Person__c> personList = new  List <Person__c>();
    for(Person__c person : Trigger.new){
      if(Trigger.oldMap.get(person.Id).Health_Status__c != person.Health_Status__c){
        person.Health_Status__c = String.valueOf(Datetime.now()); 
      }
    }
    update personList;
  }
 }
}