public with sharing class CTPeopleTracingDataCleanupBatch implements Database.Batchable <SObject> {
    public Database.QueryLocator start (Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM  People_Tracing__c WHERE Contact_Date__c < LAST_N_DAYS:30');
    }

    public void execute (Database.BatchableContext BC, List <People_Tracing__c> scope){
        delete scope;
    }

    public void finish (Database.BatchableContext BC){
        System.debug('Batch finished');
    }
}