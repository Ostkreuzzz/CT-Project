public with sharing class CTDataCleanUpSchedule implements Schedulable{
    public static final String CRON = '0 0 3 * * ?';
    public void execute (SchedulableContext SC) {
        CTPeopleTracingDataCleanupBatch peopleTracingBatch = new CTPeopleTracingDataCleanupBatch();
        Database.executeBatch(peopleTracingBatch, 2000);

        CTLocationTracingDataCleanupBatch locationTracingBatch = new CTLocationTracingDataCleanupBatch();
        Database.executeBatch(locationTracingBatch, 2000);

        CTUpdatePersonStatusBatch PersonStatusBatch = new CTUpdatePersonStatusBatch();
        Database.executeBatch(PersonStatusBatch, 2000);

    }
}