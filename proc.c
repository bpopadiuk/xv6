#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#ifdef CS333_P2
#include "uproc.h"
#endif

#ifdef CS333_P3P4
struct StateLists {
    struct proc* ready[MAXPRIO + 1];
    struct proc* readyTail[MAXPRIO + 1];
    struct proc* free;
    struct proc* freeTail;
    struct proc* sleep;
    struct proc* sleepTail;
    struct proc* zombie;
    struct proc* zombieTail;
    struct proc* running;
    struct proc* runningTail;
    struct proc* embryo;
    struct proc* embryoTail;
};
#endif

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
  #ifdef CS333_P3P4
  struct StateLists pLists;
  uint PromoteAtTime;
  #endif
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);


#ifdef CS333_P3P4
static void initProcessLists(void);
static void initFreeList(void);
static int stateListAdd(struct proc** head, struct proc** tail, struct proc* p);
static int stateListRemove(struct proc** head, struct proc** tail, struct proc* p);
static void assertState(struct proc* p, enum procstate state);
static void demote(struct proc* p);
static void promoteAll(void);
struct proc* selectProc(void);
#endif

#ifdef CS333_P3P4
int
setpriority(int pid, int priority) 
{
    int i;
    struct proc *p;

    // Check that priority is within legal bounds
    if(priority < 0 || priority > MAXPRIO)
        return -1;

    // Search the running list
    p = ptable.pLists.running;
    while(p) {
        if(p->pid == pid) {
            p->priority = priority;
            p->budget = BUDGET;
            return 0;
        }
        p = p->next;
    }

    // Search the sleep list
    p = ptable.pLists.sleep;
    while(p) {
        if(p->pid == pid) {
            p->priority = priority;
            p->budget = BUDGET;
            return 0;
        }
        p = p->next;
    }

    // Search the ready lists
    for(i = 0; i <= MAXPRIO; i++ ) {
        p = ptable.pLists.ready[i];
        while(p) {
            if(p->pid == pid) {
                if(p->priority == priority) // already set to right priority, do nothing and return
                    return 0;
                p->priority = priority;
                p->budget = BUDGET;
                // if on the ready list we need to move it to the proper queue
                stateListRemove(&ptable.pLists.ready[i], &ptable.pLists.readyTail[i], p);
                stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
                return 0;
            }
            p = p->next;
        }
    }
    
    // Did not find process matching pid
    return -1;

}
#endif

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  #ifndef CS333_P3P4
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  #else
  if(ptable.pLists.free) {
    p = ptable.pLists.free;
    goto found;
  }
  #endif
  release(&ptable.lock);
  return 0;

found:
  #ifdef CS333_P3P4
  if(stateListRemove(&ptable.pLists.free, &ptable.pLists.freeTail, p) < 0)
    panic("stateListRemove() failed to remove p from free list in allocproc()");
  assertState(p, UNUSED);
  #endif
  p->state = EMBRYO;
  #ifdef CS333_P3P4
  stateListAdd(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p);
  #endif

  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    #ifdef CS333_P3P4
    if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) < 0)
        panic("stateListRemove() failed to remove p from embryo list in allocproc()");
    assertState(p, EMBRYO);
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
    #endif
    p->state = UNUSED;

    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  #ifdef CS333_P1
  p->start_ticks = ticks;
  #endif  
  #ifdef CS333_P2
  p->cpu_ticks_total = 0;
  p->cpu_ticks_in = 0;
  #endif
  #ifdef CS333_P3P4
  p->priority = 0;
  p->budget = BUDGET;
  #endif

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  #ifdef CS333_P3P4
  acquire(&ptable.lock);
  initProcessLists();
  initFreeList();
  ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
  release(&ptable.lock);  
  #endif

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  #ifdef CS333_P2
  // Set default UID and GID
  p->uid = UID_DEFAULT;
  p->gid = GID_DEFAULT;\

  p->parent = 0;
  #endif

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  #ifdef CS333_P3P4
  if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) < 0)
    panic("stateListRemove() failed to remove p from embryo list in userinit()");
  assertState(p, EMBRYO);
  #endif

  p->state = RUNNABLE;
  #ifdef CS333_P3P4
  stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
  #endif
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    #ifdef CS333_P3P4
    acquire(&ptable.lock);
    if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, np) < 0)
      panic("stateListRemove() failed to remove np from embryo list in fork()");
    assertState(np, EMBRYO);
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, np);
    release(&ptable.lock);
    #endif
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  #ifdef CS333_P2
  // Inherit parent UID and GID
  np->uid = proc->uid;
  np->gid = proc->gid;
  #endif

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
  #ifdef CS333_P3P4
  if(stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryo, np) < 0)
    panic("stateListRemove() failed to remove np from embryo list in fork() (line 274)");
  assertState(np, EMBRYO);
  stateListAdd(&ptable.pLists.ready[np->priority], &ptable.pLists.readyTail[np->priority], np);
  #endif
  np->state = RUNNABLE;
  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
#ifndef CS333_P3P4
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}
#else
void
exit(void)
{
  struct proc *p;
  int fd;
  int i;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

    p = ptable.pLists.embryo;
    while(p) {
        if(p->parent == proc) {
            p->parent = initproc;
        }
        p = p->next;
    }

    p = ptable.pLists.running;
    while(p) {
        if(p->parent == proc) {
            p->parent = initproc;
        }
        p = p->next;
    }    

    for(i = 0; i <= MAXPRIO; i++) {
        p = ptable.pLists.ready[i];
        while(p) {
            if(p->parent == proc) {
                p->parent = initproc;
            }
            p = p->next;
        }
    }    

    p = ptable.pLists.sleep;
    while(p) {
        if(p->parent == proc) {
            p->parent = initproc;
        }
        p = p->next;
    }    

    p = ptable.pLists.zombie;
    while(p) {
        if(p->parent == proc) {
            p->parent = initproc;
            wakeup1(initproc);
        }    
        p = p->next;
    }    
  // Jump into the scheduler, never to return.
  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) < 0)
    panic("stateListRemove() failed to remove proc from running list in exit()");
  assertState(proc, RUNNING);
  proc->state = ZOMBIE;
  stateListAdd(&ptable.pLists.zombie, &ptable.pLists.zombieTail, proc);
  sched();
  panic("zombie exit");

}

#endif

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
#ifndef CS333_P3P4
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
#else
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  int i;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;

    p = ptable.pLists.zombie;
    while(p) {
        if(p->parent == proc) {
            pid = p->pid;
            kfree(p->kstack);
            p->kstack = 0; 
            freevm(p->pgdir);
            if(stateListRemove(&ptable.pLists.zombie, &ptable.pLists.zombieTail, p) < 0) 
                panic("stateListRemove() failed to remove p from zombie list in wait()");
            assertState(p, ZOMBIE);
            p->state = UNUSED;
            stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
            p->pid = 0; 
            p->parent = 0; 
            p->name[0] = 0; 
            p->killed = 0; 
            release(&ptable.lock);
            return pid; 
        }    
        p = p->next;
    }    

    p = ptable.pLists.embryo;
    while(p) {
        if(p->parent == proc)
            havekids = 1;
        p = p->next;
    }

    p = ptable.pLists.running;
    while(p) {
        if(p->parent == proc)
            havekids = 1;
        p = p->next;
    }

    for(i = 0; i <= MAXPRIO; i++) {
        p = ptable.pLists.ready[i];
        while(p) {
            if(p->parent == proc)
                havekids = 1;
            p = p->next;
        }
    }

    p = ptable.pLists.sleep;
    while(p) {
        if(p->parent == proc)
            havekids = 1;
        p = p->next;
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
#endif

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
#ifndef CS333_P3P4
// original xv6 scheduler. Use if CS333_P3P4 NOT defined.
void
scheduler(void)
{
  struct proc *p;
  int idle;  // for checking if processor is idle

  for(;;){
    // Enable interrupts on this processor.
    sti();

    idle = 1;  // assume idle unless we schedule a process
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      idle = 0;  // not idle this timeslice
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      #ifdef CS333_P2
      p->cpu_ticks_in = ticks;
      #endif
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
  }
}

#else
// P4 Improved Scheduler. Uses Ready List to find process 
// instead of looping through ptable.
void
scheduler(void)
{
    struct proc *p; 
    int idle;

    for(;;){
      
      // Enable interrupts on this processor.
      sti();

      idle = 1; // assume idle unless we schedule a process

      // Loop over process table looking for process to run.
      acquire(&ptable.lock);

      // Check if it's time for periodic upward adjustment
      if(ticks >= ptable.PromoteAtTime) {
        promoteAll();
        ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
      } 
      
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      p = selectProc();
        
      if(p) {
        idle = 0; // not idle this timeslice
        proc = p;
        switchuvm(p);
        if(stateListRemove(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p) < 0) {
            panic("stateListRemove() failed to remove p from ready list in scheduler()");
        }
        assertState(p, RUNNABLE);
        p->state = RUNNING;
        stateListAdd(&ptable.pLists.running, &ptable.pLists.runningTail, p);
        #ifdef CS333_P2
        p->cpu_ticks_in = ticks;
        #endif
        swtch(&cpu->scheduler, proc->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
      }
      release(&ptable.lock);
      
      // if idle, wait for next interrupt
      if (idle) {
        sti();
        hlt();
      }    
    }
}
#endif

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  #ifdef CS333_P2
  proc->cpu_ticks_total += ticks - proc->cpu_ticks_in;
  #endif
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  #ifdef CS333_P3P4
  // Check if proc has exhausted its budget
  // demote if necessary before removing from running list

  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) < 0)
    panic("stateListRemove() failed to remove proc from running list in yield()");
  assertState(proc, RUNNING);

  // Check if proc has exhausted its budget
  // demote if necessary before removing from running list
  proc->budget = proc->budget - (ticks - proc->cpu_ticks_in);
  if(proc->budget <= 0)
    demote(proc);
  
  stateListAdd(&ptable.pLists.ready[proc->priority], &ptable.pLists.readyTail[proc->priority], proc);
  #endif
  proc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
// 2016/12/28: ticklock removed from xv6. sleep() changed to
// accept a NULL lock to accommodate.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){
    acquire(&ptable.lock);
    if (lk) release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  #ifdef CS333_P3P4
  if(stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) < 0)
    panic("stateListRemove() failed to remove proc from running in sleep()");

  // Check if proc has exhausted its budget
  proc->budget = proc->budget - (ticks - proc->cpu_ticks_in);
  if(proc->budget <= 0)
    demote(proc);  

  assertState(proc, RUNNING);
  stateListAdd(&ptable.pLists.sleep, &ptable.pLists.sleepTail, proc);
  
  #endif
  proc->state = SLEEPING;
  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}

//PAGEBREAK!
#ifndef CS333_P3P4
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
#else
static void
wakeup1(void *chan)
{
 struct proc *p;

    p = ptable.pLists.sleep;
    while(p) {
        if(p->state == SLEEPING && p->chan == chan) {
            if(stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) < 0)
                panic("stateListRemove() failed to remove p from sleep list in wakeup1()");
            assertState(p, SLEEPING);
            stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
            p->state = RUNNABLE;
        }
        p = p->next;
    }
}
#endif

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
#ifndef CS333_P3P4
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
#else
int
kill(int pid)
{
  struct proc *p;
  int i;

  acquire(&ptable.lock); 

  // Look through each list for process we're looking for. Shortest lists
  // first for efficiency

  // Look through embryo list
  p = ptable.pLists.embryo;
  while(p) {
    if(p->pid == pid) {
      p->killed = 1; 
      release(&ptable.lock);
      return 0;
    }    
    p = p->next;
  }

  // Look through running list
  p = ptable.pLists.running;
  while(p) {
    if(p->pid == pid) {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
    p = p->next;
  }

  // Look through ready list 
  for(i = 0; i<= MAXPRIO; i++) {
    p = ptable.pLists.ready[i];
    while(p) {
        if(p->pid == pid) {
        p->killed = 1; 
        // promote to top queue if need be to expedite trip out of system
        if(p->priority > 0) {
            if(stateListRemove(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p) < 0) {
                panic("stateListRemove failed to remove p from ready list in kill()");
            }
            p->priority = 0;
            stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
        }
        release(&ptable.lock);
        return 0;
        }       
        p = p->next;
    }
  }

  // Look through sleep list
  p = ptable.pLists.sleep;
  while(p) {
    if(p->pid == pid) {
      p->killed = 1;
      // wake sleeping process
      if(stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) < 0)
        panic("stateListRemove() failed to remove p from sleep list in kill()");
      assertState(p, SLEEPING);
      p->state = RUNNABLE;
      p->priority = 0; // promote to top queue to expedite its trip out of the system
      stateListAdd(&ptable.pLists.ready[p->priority], &ptable.pLists.readyTail[p->priority], p);
      release(&ptable.lock);
      return 0;
    }    
    p = p->next;
  }

  // Look through zombie list
  p = ptable.pLists.zombie;
  while(p) {
    if(p->pid == pid) {
      p->killed = 1; 
      release(&ptable.lock);
      return 0;
    }    
    p = p->next;
  }

  release(&ptable.lock);
  return -1;
}
#endif

static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
};

// Populate uproc table from ptable
#ifdef CS333_P2
int
getprocs(int max, struct uproc *table)
{
    struct proc *p;
    int pcount;

    pcount = 0;
    max = (max < NPROC) ? max : NPROC;
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if(p->state == UNUSED || p->state == EMBRYO)
            continue;
        if(pcount == max)
            break;
        table->pid = p->pid;
        table->uid = p->uid;
        table->gid = p->gid;
        if(p->pid == 1)
            table->ppid = p->pid;
        else
            table->ppid = p->parent->pid;
        table->elapsed = ticks - p->start_ticks;
        table->cpu_ticks_total = p->cpu_ticks_total;
        safestrcpy(table->state, states[p->state], 7);
        table->sz = p->sz;
        safestrcpy(table->name, p->name, sizeof(p->name));
        #ifdef CS333_P3P4
        table->priority = p->priority;
        #endif
        table += 1;
        pcount += 1;
    }
    release(&ptable.lock);
        
    return pcount;
}    
#endif  

// Helper funcs for Console Debugging Commands: control-r, 
// control-f, control-s, control-z. Print ready list, free list,
// sleep list, and zombie list respectively.

#ifdef CS333_P3P4
void
readydump(void) {
    struct proc* p;
    int i;

    cprintf("Ready List Processes:\n");
    acquire(&ptable.lock);
    
    for(i = 0; i <= MAXPRIO; i++) {
        cprintf("%d: ", i);
        p = ptable.pLists.ready[i];
        if(p) {
            cprintf("(%d, %d) ", p->pid, p->budget);
            p = p->next;
        }
        while(p) {
            cprintf("-> (%d, %d) ", p->pid, p->budget);
            p = p->next;
        }
        cprintf("\n\n");
    }
    release(&ptable.lock);
}

void
freedump(void) {
    struct proc* p;
    int pcount = 0;

    acquire(&ptable.lock);
    p = ptable.pLists.free;
    while(p) {
        pcount += 1;
        p = p->next;
    }
    release(&ptable.lock);

    cprintf("Free List Size: %d processes\n", pcount);
}

void
sleepdump(void) {
    struct proc* p;

    cprintf("Sleep List Processes:\n");
    acquire(&ptable.lock);
    p = ptable.pLists.sleep;
    while(p) {
        cprintf("%d -> ", p->pid);
        p = p->next;
    }
    release(&ptable.lock);
    cprintf("\n");
}

void
zombiedump(void) {
    struct proc* p;
    
    cprintf("Zombie List Processes:\n");
    acquire(&ptable.lock);
    p = ptable.pLists.zombie;
    while(p) {
        cprintf("(%d, %d) -> ", p->pid, p->parent ? p->parent->pid : p->pid);
        p = p->next;
    }
    release(&ptable.lock);
    cprintf("\n");
}
#endif

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.

#ifdef CS333_P1
void
print_ticks_as_seconds(uint milliseconds)
{
  uint integer_part = milliseconds / 1000;
  uint fractional_part = milliseconds % 1000;
  cprintf("%d.", integer_part);
  if(fractional_part < 10)
    cprintf("00");
  else if(fractional_part < 100)
    cprintf("0");
  cprintf("%d", fractional_part);
}
#endif

#ifdef CS333_P1
void
procdumpP1(struct proc *p, char *state)
{
  uint elapsed = ticks - p->start_ticks;
  cprintf("%d\t%s\t\t", p->pid, p->name);
  print_ticks_as_seconds(elapsed);
  cprintf("\t%s\t%d\t", state, p->sz);
}
#endif

#ifdef CS333_P2
void
procdumpP2(struct proc *p, char *state)
{
  uint elapsed = ticks - p->start_ticks;


  cprintf("%d\t%s\t\t%d\t%d\t", p->pid, p->name, p->uid, p->gid);
  cprintf("%d\t", p->parent ? p->parent->pid : p->pid);
  print_ticks_as_seconds(elapsed);
  cprintf("\t");
  print_ticks_as_seconds(p->cpu_ticks_total);
  cprintf("\t%s\t%d\t", state, p->sz);
}
#endif

#ifdef CS333_P3P4
void
procdumpP3P4(struct proc *p, char *state)
{
  uint elapsed = ticks - p->start_ticks;


  cprintf("%d\t%s\t\t%d\t%d\t", p->pid, p->name, p->uid, p->gid);
  cprintf("%d\t", p->parent ? p->parent->pid : p->pid);
  cprintf("%d\t", p->priority);
  print_ticks_as_seconds(elapsed);
  cprintf("\t");
  print_ticks_as_seconds(p->cpu_ticks_total);
  cprintf("\t%s\t%d\t", state, p->sz);
}
#endif

void
procdump(void)
{
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

// Conditional Compilation trick used with permission from Mark Morrissey
#if defined(CS333_P3P4)
#define HEADER "\nPID\tName\t\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined(CS333_P2)
#define HEADER "\nPID\tName\t\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined(CS333_P1)
#define HEADER "\nPID\tName\t\tElapsed\tState\tSize\t PCs\n"
#else
#define HEADER ""
#endif

  cprintf(HEADER);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
#if defined(CS333_P3P4)
    procdumpP3P4(p, state);
#elif defined(CS333_P2)
    procdumpP2(p, state);
#elif defined(CS333_P1)
    procdumpP1(p, state);
#else
    cprintf("%d %s %s", p->pid, state, p->name);
#endif
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

#ifdef CS333_P3P4
static int
stateListAdd(struct proc** head, struct proc** tail, struct proc* p)
{
  if (*head == 0) {
    *head = p;
    *tail = p;
    p->next = 0;
  } else {
    (*tail)->next = p;
    *tail = (*tail)->next;
    (*tail)->next = 0;
  }

  return 0;
}


static int
stateListRemove(struct proc** head, struct proc** tail, struct proc* p)
{
  if (*head == 0 || *tail == 0 || p == 0) {
    return -1;
  }

  struct proc* current = *head;
  struct proc* previous = 0;

  if (current == p) {
    *head = (*head)->next;
    return 0;
  }

  while(current) {
    if (current == p) {
      break;
    }

    previous = current;
    current = current->next;
  }

  // Process not found, hit eject.
  if (current == 0) {
    return -1;
  }

  // Process found. Set the appropriate next pointer.
  if (current == *tail) {
    *tail = previous;
    (*tail)->next = 0;
  } else {
    previous->next = current->next;
  }

  // Make sure p->next doesn't point into the list.
  p->next = 0;

  return 0;
}

static void
initProcessLists(void) {
  int i;

  for(i = 0; i <= MAXPRIO; i++) {
    ptable.pLists.ready[i] = 0;
    ptable.pLists.readyTail[i] = 0;
  }
  ptable.pLists.free = 0;
  ptable.pLists.freeTail = 0;
  ptable.pLists.sleep = 0;
  ptable.pLists.sleepTail = 0;
  ptable.pLists.zombie = 0;
  ptable.pLists.zombieTail = 0;
  ptable.pLists.running = 0;
  ptable.pLists.runningTail = 0;
  ptable.pLists.embryo = 0;
  ptable.pLists.embryoTail = 0;
} 

static void
initFreeList(void) {
  if (!holding(&ptable.lock)) {
    panic("acquire the ptable lock before calling initFreeList\n");
  }

  struct proc* p;

  for (p = ptable.proc; p < ptable.proc + NPROC; ++p) {
    p->state = UNUSED;
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
  }
}
#endif

// Helper function to double check process state before removing from list
#ifdef CS333_P3P4
static void assertState(struct proc* p, enum procstate state) {
    if(p->state != state) {
        cprintf("expected %d, got %d\n", state, p->state);
        panic("process list/state mismatch");
    }    
}

// demote p by decrementing its priority field, reset budget
// will be moved to appropriate ready queue when stateListAdd() is called
static void
demote(struct proc* p) {
    p->budget = BUDGET; // reset budget
    
    // Only demote proc if it isn't already on lowest priority queue
    if(p->priority < MAXPRIO)  
        p->priority += 1;
}

// promote all processes up to the next queue
static void
promoteAll(void) {
    int i;
    struct proc *p;

    // if system is not running MLFQ hit eject
    if(MAXPRIO < 1)
        return;

    // promote sleeping procs
    p = ptable.pLists.sleep;
    while(p) {
        if(p->priority > 0)
            p->priority -= 1;
        p = p->next;
    }

    // promote running procs
    p = ptable.pLists.running;
    while(p) {
        if(p->priority > 0)
            p->priority -= 1;
        p = p->next;
    }

    // ready lists
    // first, update priority fields in each struct (top queue can't be promoted any further)
    for(i = 1; i <= MAXPRIO; i++) {
        //set priority fields in each proc struct
        p = ptable.pLists.ready[i];
        while(p) {
            p->priority -= 1;
            p = p->next;
        }
    }    

    // Move pointers to promote queues
    // start by promoting second level queue to back of first level queue
    if(ptable.pLists.ready[0] && ptable.pLists.ready[1]) { // procs on both level 0 and level 1 queues
        ptable.pLists.readyTail[0]->next = ptable.pLists.ready[1];
        ptable.pLists.readyTail[0] = ptable.pLists.readyTail[1];
        ptable.pLists.readyTail[0]->next = 0;
    } else if(!ptable.pLists.ready[0] && ptable.pLists.ready[1]) { // procs on level 1 queue but not on level 0 queue
        ptable.pLists.ready[0] = ptable.pLists.ready[1];
        ptable.pLists.readyTail[0] = ptable.pLists.readyTail[1];
        ptable.pLists.readyTail[0]->next = 0;
    }

    
    for(i = 1; i < MAXPRIO; i++) {
        // promote entire queue by pointing head and tail pointers to next lower queue        
        ptable.pLists.ready[i] = ptable.pLists.ready[i+1];
        ptable.pLists.readyTail[i] = ptable.pLists.readyTail[i+1];
    }

    // Lowest queue will be empty
    ptable.pLists.ready[MAXPRIO] = 0;
    ptable.pLists.readyTail[MAXPRIO] = 0;
    
    return;
    
}

struct proc*
selectProc(void) {
    int i = 0;
    struct proc *p;

    p = ptable.pLists.ready[i];
    while(!p) {
      i += 1;
      if(i > MAXPRIO) 
          return p;
      p = ptable.pLists.ready[i];
    }
    return p;    
}
#endif
