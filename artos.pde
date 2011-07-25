
TCB tasks[100];
TCB * task_list;
int ARTOS_idle_stk[IDLESTACKSIZE];

void ARTOS_run(){
  while(1){
    task_list->task();
    task_list->task = 0;
    task_list = task_list->next;
    if (task_list == 0){
	return;
    } 
  }
}

void ARTOS_idle(){
  while(1){
    
  }
}
//

void ARTOS_NewTask(void (* task)(void),void *taskStack, unsigned priority){
  int i;
  for(i = 0; i < 100; i++){
    if (tasks[i].task == 0){
      tasks[i].task = task;
      tasks[i].stack = taskStack;
      tasks[i].priority = priority;
      task_list = addToList(task_list, &tasks[i]);
      break;
    }
  }
}


TCB* addToList(TCB * list, TCB * task){
  if(list){
    TCB * currentNode = list;
    if(currentNode->priority > task->priority){
       task->next = currentNode;
       list = task;
       return list;
    }
    while(currentNode->next){
      if (currentNode->next->priority > task->priority){
        break;
      }
      currentNode = currentNode->next;
    }
    task->next = currentNode->next;
    currentNode->next = task;
    return list;
  } 
  else {
    task->next = 0;
    return task;
  }
} 
