#ifdef CS333_P3P4
#include "types.h"
#include "user.h"

#define NPROC 64
#define NPROC_MINUS_3 61

// Tests
#define FREE_INIT
#define FREE_UPDATE
#define ZOMBIEFREE_TEST
#define SLEEP_UPDATE
#define KILLCHECK
#define WAITCHECK
#define EXITCHECK
#define READY_TEST

#ifdef ZOMBIEFREE_TEST
int
zombiefree(void) {

    int total = 0;
    int i = 0;
    int pids[NPROC_MINUS_3];
    int pid;


    printf(1, "PRESS CTRL-S and CTRL-F, sleeping list should show init, sh, and p3test processes, free list should be %d\n", NPROC - 3);
    sleep(5 * TPS);
    

    // fork as many processes as the system will allow
    printf(1, "forking...\n");
    while((pid = fork()) > 0) {
        pids[i] = pid;
        i += 1;
        total += 1;
    }

    // children sleep for two minutes while parent does its work
    // they will be killed before this time is up.
    if(pid == 0)
        sleep(120 * TPS);

    printf(1, "maximum reached.\n");
    printf(1, "%d processes were created.\n", total);
    printf(1, "\nPRESS CTRL-F (Free list should = 0)\n");
    sleep(5 * TPS);


    // Kill all child processes, sleep to allow for checks of free list and zombie list
    for(i = 0; i < NPROC_MINUS_3; i++) {
        kill(pids[i]);
        printf(1, "killing PID %d\n", pids[i]);
        
        // Check that the first 3 processes were added to Zombie List
        if(i < 3) {
            printf(1, "\nPRESS CTRL-Z ((%d, %d) should be on Zombie List)\n", pids[i], getpid()); // zombie list contains tuple of the form (pid, ppid), use getpid() because we are in parent
            sleep(5 * TPS);
        }
        
        while(1) {
            if(wait() != -1) {
                // Check that the first 3 processes were added to Free List
                if(i < 3) {
                    printf(1, "\nPRESS CTRL-F (Free List should = %d)\n", (i + 1));
                    sleep(5 * TPS);
                }
                break;
            }
        }
    }

    // Test that exit() moves process to the zombie list
    pid = fork();
    if(pid == 0) {
        exit();
    }
    else {
        printf(1, "\nTESTING exit(), press ctrl-z\n");
        printf(1, "%d should appear on zombie list\n", pid);
        sleep(5 * TPS);
        wait();
    }
    
    return 0;
}
#endif

#ifdef READY_TEST
int
ready(void) {
    int i = 0;
    int pid;
        
    printf(1, "forking first process...\n");

    // Fork 30 processes (i < 29 because fork() still executes when the while condition fails)
    while((pid = fork()) > 0 && i < 29) {
        i += 1;
        printf(1, "forked %d processes...\n", i + 1);
    }

    if(pid > 0) {
        printf(1, "PRESS CTRL-R IN RAPID SUCCESSION (Ready List should show cyclical flow)\n");
        printf(1, "Parent waiting for children in infinite loop. Manually terminate.\n");
        wait();
    }

    // Child Process
    if(pid == 0) {
        for(;;) {
            // spin...
        }
    }
    
    return 0;
}
#endif

int
main(void) {
    #ifdef READY_TEST
    ready();
    #endif
    #ifdef ZOMBIEFREE_TEST
    zombiefree();
    #endif

    exit();
}

#endif
