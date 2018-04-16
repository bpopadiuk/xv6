#ifdef CS333_P2
#include "types.h"
#include "user.h"

/**  
* parse milliseconds and print as seconds in floating point format
*/
void
print_ticks_as_seconds(uint milliseconds)
{
  uint integer_part = milliseconds / 1000;
  uint fractional_part = milliseconds % 1000;
  printf(1, "%d.", integer_part);

  if(fractional_part < 10) 
    printf(1, "00");
  else if(fractional_part < 100)
    printf(1, "0");

  printf(1, "%d", fractional_part);
}

int
main(int argc, char *argv[])
{
    int ret;
    uint t1, t2;
    uint running_time;

    if(argc < 2) { // if no arguments passed, print "ran in 0.000 seconds." and exit
        running_time = 0;
        printf(1, "ran in ");
        print_ticks_as_seconds(running_time);
        printf(1, " seconds.\n");
        exit();
    }

    t1 = uptime();
    ret = fork();
    if(ret == 0) { // run the program passed to time in child process
        exec(argv[1], &argv[1]);
        printf(2, "ERROR: exec failed to execute %s\n", argv[1]);
        exit();

    } else if(ret == -1) { // handle fork() failure
        printf(2, "ERROR: fork failed\n");
        exit();

    } else { // reap child process and store its running time to running_time
        wait();
        t2 = uptime();
        running_time = t2 - t1;
    }

    printf(1, "%s ran in ", argv[1]);
    print_ticks_as_seconds(running_time);
    printf(1, " seconds.\n");            
    exit();
    
}

#endif
