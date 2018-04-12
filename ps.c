#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "uproc.h"

#define MAX 64
#define PSHEADER "\nPID\tUID\tGID\tPPID\tELAPSED\tCPU\tSTATE\tSIZE\tNAME\n"

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
main(void)
{
    int i;
    int nprocesses;
    struct uproc table[MAX];

    nprocesses = getprocs(MAX, &table[0]);

    if(nprocesses < 0) {
        printf(1, "ERROR: unable to construct Process Table\n");
        exit();
    }

    printf(1, PSHEADER);    

    for(i = 0; i < nprocesses; i++) {
        if(table[i].pid == 0)
            break;
        printf(1, "%d\t%d\t%d\t%d\t", table[i].pid, table[i].uid, table[i].gid, table[i].ppid);
        print_ticks_as_seconds(table[i].elapsed);
        printf(1, "\t");
        print_ticks_as_seconds(table[i].cpu_ticks_total);
        printf(1, "\t%s\t%d\t%s\n", table[i].state, table[i].sz, table[i].name);
    }   
  
    exit();
}
#endif
