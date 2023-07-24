trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
  switch on Trigger.operationType {
    when AFTER_INSERT {
      List<Task> taskList = new List<Task>();
      for (Opportunity opp : Trigger.new){
        if (opp.StageName == 'Closed Won'){
          Task followUpTask = new Task(Subject = 'Follow Up Test Task',WhatId = opp.id);
          taskList.add(followUpTask);
        }
      }
      insert taskList;
    }
    when AFTER_UPDATE {
      List<Task> taskList = new List<Task>();
      for (Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won'){
          Task followUpTask = new Task(Subject = 'Follow Up Test Task',WhatId = opp.id);
          taskList.add(followUpTask);
        }
      }
      insert taskList;
    }
  }
}