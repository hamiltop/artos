#include "artos.h"

int my_task_stk[STACKSIZE];
int my_other_task_stk[STACKSIZE];
extern TCB * task_list;

int ledPin = 13;
//
//
//// This is where interrupts and things should be set up.
void setup(){
  pinMode(ledPin, OUTPUT) ;
  Serial.begin(9600);

  ARTOS_NewTask(my_task,my_task_stk, 20);
  ARTOS_NewTask(my_task,my_task_stk, 10);
  ARTOS_NewTask(my_other_task,my_other_task_stk, 15);
}

void loop(){

  ARTOS_run();
  

}

void update_and_report();

void my_task(){
  digitalWrite(ledPin,HIGH);
  delay(5000);
  Serial.println("something else is up");
  update_and_report();
}

void update_and_report(){
  Serial.print("I am ");
  Serial.println((unsigned)task_list);
  if(task_list->id == 1 && task_list->next && task_list->next->task != ARTOS_idle){
    Serial.print("next is ");
    Serial.println((unsigned)task_list->next);
    Serial.println("updating priority");
    ARTOS_UpdateCurrentTaskPriority(30);
  }else{
    Serial.println("deleting self");
    ARTOS_DeleteCurrentTask();
  }
}

void my_other_task(){
  digitalWrite(ledPin,LOW);
  delay(5000);
  Serial.println("nothing is up");
  update_and_report();
}



