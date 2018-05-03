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

    printf(1, "forking...\n");
    while((pid = fork()) > 0) {
        pids[i] = pid;
        i += 1;
        total += 1;
    }

    if(pid == 0)
        sleep(30 * TPS);

    printf(1, "maximum reached.\n");
    printf(1, "%d processes were created.\n", total);
    sleep(5 * TPS);

    for(i = 0; i < NPROC_MINUS_3; i++) {
        kill(pids[i]);
        printf(1, "killing PID %d\n", pids[i]);
        while(1) {
            if(wait() != -1)
                break;
        }
    }

    printf(1, "TEST PASSED\n");

    exit();
}

#endif
