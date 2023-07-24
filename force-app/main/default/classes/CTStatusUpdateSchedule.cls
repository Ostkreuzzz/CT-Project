public with sharing class CTStatusUpdateSchedule {
    public static final String CRON = '0 0 3 * * ?';
    public void execute (SchedulableContext SC) {
        CTUpdatePersonStatusBatch personStatusBatch = new CTUpdatePersonStatusBatch();
        Database.executeBatch(personStatusBatch, 2000);

        CTLocationUpdateStatusBatch locationStatusBatch = new CTLocationUpdateStatusBatch();
        Database.executeBatch(locationStatusBatch, 2000);
    }
}