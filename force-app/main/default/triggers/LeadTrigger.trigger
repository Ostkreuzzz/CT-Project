trigger LeadTrigger on Lead (before insert, before update, after update) {
    
    switch on Trigger.operationType	{
        when BEFORE_INSERT	{
            for (Lead leadRecord : Trigger.new){
                if (String.isBlank(leadRecord.LeadSource)){
                    leadRecord.LeadSource = 'Other';
                }
                if (String.isBlank(leadRecord.Industry)){
                    leadRecord.addError ('The industry field cannot be blank');
                }
            }
        }
        when BEFORE_UPDATE	{
            for (Lead leadRecord : Trigger.new){
                if (String.isBlank(leadRecord.LeadSource)){
                    leadRecord.LeadSource = 'Other';
                }
                if ((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted') && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'){
                    leadRecord.Status.addError('Cannot change Lead from open to closed');
                }
            }
        }
        when AFTER_UPDATE {
            List <Task> taskList = new List <Task>();
            for (Lead leadRecord : Trigger.new){
                Task leadTask = new Task(Subject = 'Follow up on Lead Status' , Ownerid = leadRecord.id );    
                taskList.add(leadTask);
            }
            insert taskList;
    	}
    }
}