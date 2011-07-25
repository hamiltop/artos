#include "artos.h"

int my_task_stk[STACKSIZE];
int my_other_task_stk[STACKSIZE];


int ledPin = 13;
//
//
//// This is where interrupts and things should be set up.
void setup(){
  pinMode(ledPin, OUTPUT) ;
  Serial.begin(9600);

  ARTOS_NewTask(my_task,my_task_stk, 20);
  ARTOS_NewTask(my_other_task,my_other_task_stk, 15);
  ARTOS_NewTask(my_task,my_task_stk, 10);

}

void loop(){

  ARTOS_run();
  

}

void my_task(){
  digitalWrite(ledPin,HIGH);
  delay(5000);
  Serial.println("something else is up");
}

void my_other_task(){
  digitalWrite(ledPin,LOW);
  delay(5000);
  Serial.println("nothing is up");
}



