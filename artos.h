#define IDLESTACKSIZE 100
#define STACKSIZE 100

struct t_c_b {
  int state;
  unsigned char priority;
  void (* task)(); 
  struct t_c_b * next;
  void * stack;
};

typedef struct t_c_b TCB;

void ARTOS_idle();
void ARTOS_run();
void ARTOS_NewTask(void (* task)(void),void *taskStack, unsigned priority);
TCB* addToList(TCB * list, TCB * task);


void my_task();
void my_other_task();

