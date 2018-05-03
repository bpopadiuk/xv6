#ifdef CS333_P3P4
#include "types.h"
#include "user.h"

#define NPROC_MINUS_3 61

int
main(void) {

    int total = 0;
    int i = 0;
    int pids[NPROC_MINUS_3];
    int pid;

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
        
        // Check that the first 5 processes were added to Zombie List
        if(i < 5) {
            printf(1, "\nPRESS CTRL-Z ((%d, 3) should be on Zombie List)\n", pids[i]);
            sleep(5 * TPS);
        }
        
        while(1) {
            if(wait() != -1) {
                // Check that the first 5 processes were added to Free List
                if(i < 5) {
                    printf(1, "\nPRESS CTRL-F (Free List should = %d)\n", (i + 1));
                    sleep(5 * TPS);
                }
                break;
            }
        }
    }

    printf(1, "TEST PASSED\n");

    exit();
}

#endif
