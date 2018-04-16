/*
  A basic test suite for Portland State University CS333 Operating Systems Project 2.
  Created by Joe Coleman
*/
#ifdef CS333_P2
#include "types.h"
#include "user.h"

// comment out tests for features the student doesn't have implemented
// Note the CPUTIME_TEST requires GETPROCS_TEST
#define UIDGIDPPID_TEST
#define CPUTIME_TEST
#define GETPROCS_TEST
#define TIME_TEST


#ifdef GETPROCS_TEST
#include "uproc.h"
#endif

#ifdef UIDGIDPPID_TEST
static void
testppid(void){
  int ret, pid, ppid;

  printf(1, "\n----------\nRunning PPID Test\n----------\n");
  pid = getpid();
  ret = fork();
  if(ret == 0){
    ppid = getppid();
    if(ppid != pid)
      printf(2, "FAILED: Parent PID is %d, Child's PPID is %d\n", pid, ppid);
    else
      printf(1, "** Test passed! **\n");
    exit();
  }
  else
    wait();
}

static int
testgid(uint new_val, uint expected_get_val, int expected_set_ret){
  int ret;
  uint post_gid, pre_gid;
  int success = 0;

  pre_gid = getgid();
  ret = setgid(new_val);
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
    success = -1;
  }
  post_gid = getgid();
  if(post_gid != expected_get_val){
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n", 
          pre_gid, new_val, post_gid, expected_get_val);
    success = -1;
  }
  return success;
}

static int
testuid(uint new_val, uint expected_get_val, int expected_set_ret){
  int ret;
  uint post_uid, pre_uid;
  int success = 0;

  pre_uid = getuid();
  ret = setuid(new_val);
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
    success = -1;
  }
  post_uid = getuid();
  if(post_uid != expected_get_val){
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n", 
          pre_uid, new_val, post_uid, expected_get_val);
    success = -1;
  }
  return success;
}

static void
testuidgid(void)
{
  int uid, gid;
  int success = 0;

  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
  uid = getuid();
  if(uid < 0 || uid > 32767){
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
    success = -1;
  }
  if (testuid(0, 0, 0))
    success = -1;
  if (testuid(5, 5, 0))
    success = -1;
  if (testuid(32767, 32767, 0))
    success = -1;
  if (testuid(32768, 32767, -1))
    success = -1;
  if (testuid(-1, 32767, -1))
    success = -1;
 
  gid = getgid();
  if(gid < 0 || gid > 32767){
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
    success = -1;
  }
  if (testgid(0, 0, 0))
    success = -1;
  if (testgid(5, 5, 0))
    success = -1;
  if (testgid(32767, 32767, 0))
    success = -1;
  if (testgid(-1, 32767, -1))
    success = -1;
  if (testgid(32768, 32767, -1))
    success = -1;
 
  if (success == 0)
    printf(1, "** All tests passed! **\n");
}

static void
testuidgidinheritance(void){
  int ret, success, uid, gid;
  success = 0;

  printf(1, "\n----------\nRunning UID / GID Inheritance Test\n----------\n");
  if (testuid(12345, 12345, 0))
    success = -1;
  if (testgid(12345, 12345, 0))
    success = -1;
  if(success != 0)
    return;

  ret = fork();
  if(ret == 0){
    uid = getuid();
    gid = getgid();
    if(uid != 12345){
      printf(2, "FAILED: Parent UID is 12345, child UID is %d\n", uid);
    }
    else if(gid != 12345){
      printf(2, "FAILED: Parent GID is 12345, child GID is %d\n", gid);
    }
    else
      printf(1, "** Test Passed! **\n"); 
    exit();
  }
  else {
    wait();
  }
}
#endif

#ifdef GETPROCS_TEST
#ifdef CPUTIME_TEST
// Simple test to have the program sleep for 200 milliseconds to see if CPU_time properly doesn't change
// And then gets CPU_time again to see if elapsed CPU_total_ticks is reasonable
static int
getcputime(char * name, struct uproc * table){
  struct uproc *p = 0;
  int size;
  
  size = getprocs(64, table);
  for(int i = 0; i < size; ++i){
    if(strcmp(table[i].name, name) == 0){
      p = table + i;
      break;
    }
  }
  if(p == 0){
    printf(2, "FAILED: Test program \"%s\" not found in table returned by getprocs\n", name);
    return -1;
  }
  else
    return (int) p->cpu_ticks_total;
}

static void
testcputime(char * name){
  struct uproc *table;
  uint time1, time2, pre_sleep, post_sleep;
  int success = 0;
  int i, num;

  printf(1, "\n----------\nRunning CPU Time Test\n----------\n");
  table = malloc(sizeof(struct uproc) * 64);
  printf(1, "This will take a couple seconds\n");

  // Loop for a long time to see if the elapsed CPU_total_ticks is in a reasonable range
  time1 = getcputime(name, table);
  for(i = 0, num = 0; i < 1000000; ++i){
    ++num;
    if(num % 100000 == 0){
      pre_sleep = getcputime(name, table);
      sleep(200);
      post_sleep = getcputime(name, table);
      if((post_sleep - pre_sleep) >= 100){
        printf(2, "FAILED: CPU_total_ticks changed by 100+ milliseconds while process was asleep\n");
        success = -1;
      }
    }
  }
  time2 = getcputime(name, table);
  if((time2 - time1) < 0){
    printf(2, "FAILED: difference in CPU_total_ticks is negative.  T2 - T1 = %d\n", (time2 - time1));
    success = -1;
  }
  if((time2 - time1) > 400){
    printf(2, "ABNORMALLY HIGH: T2 - T1 = %d milliseconds.  Run test again\n", (time2 - time1));
    success = -1; 
  }
  printf(1, "T2 - T1 = %d milliseconds\n", (time2 - time1));
  free(table);

  if(success == 0)
    printf(1, "** All Tests Passed! **\n");
}
#endif
#endif

#ifdef GETPROCS_TEST
// Fork to 64 process and then make sure we get all when passing table array
// of sizes 1, 16, 64, 72
static int
testprocarray(int max, int expected_ret, char * name){
  struct uproc * table;
  int ret, success, num_init, num_sh, num_this;
  success = num_init = num_sh = num_this = 0;
  
  table = malloc(sizeof(struct uproc) * max);
  ret = getprocs(max, table);
  for (int i = 0; i < ret; ++i){
    if(strcmp(table[i].name, "init") == 0)
      ++num_init;
    else if(strcmp(table[i].name, "sh") == 0)
      ++num_sh;
    else if(strcmp(table[i].name, name) == 0)
      ++num_this;
  }
  if (ret != expected_ret){
    printf(2, "FAILED: getprocs(%d) returned %d, expected %d\n", max, ret, expected_ret);
    success = -1;
  }
  else{
    printf(1, "getprocs(%d), found %d processes with names(qty), \"init\"(%d), \"sh\"(%d), \"%s\"(%d)\n",
            max, ret, num_init, num_sh, name, num_this);
  }
  free(table);
  return success;
}

static int
testinvalidarray(void){
  struct uproc * table;
  int ret;

  table = malloc(sizeof(struct uproc));
  ret = getprocs(1024, table);
  free(table);
  if(ret >= 0){
    printf(2, "FAILED: called getprocs with max way larger than table and returned %d, not error\n", ret);
    return -1;
  }
  return 0;
}

static void
testgetprocs(char * name){
  int ret, success;

  printf(1, "\n----------\nRunning GetProcs Test\n----------\n");
  // Fork until no space left in ptable
  ret = fork();
  if (ret == 0){
    while((ret = fork()) == 0);
    if(ret > 0){
      wait();
      exit();
    }
    // Only return left is -1, which is no space left in ptable
    success = 0;
    if(testinvalidarray())
      success = -1;
    if(testprocarray(1, 1, name))
      success = -1;
    if(testprocarray(16, 16, name))
      success = -1;
    if(testprocarray(64, 64, name))
      success = -1;
    if(testprocarray(72, 64, name))
      success = -1;
    if (success == 0)
      printf(1, "** All Tests Passed **\n");
    exit(); 
  }
  wait();
}
#endif

#ifdef TIME_TEST
// Forks a process and execs with time + args to see how it handles no args, invalid args, mulitple args
void
testtimewitharg(char **arg){
  int ret;
 
  ret = fork();
  if (ret == 0){
    exec(arg[0], arg);
    printf(2, "FAILED: exec failed to execute %s\n", arg[0]);
    exit();
  }
  else if(ret == -1){
    printf(2, "FAILED: fork failed\n");
  }
  else
    wait();
}
void
testtime(void){
  char **arg1 = malloc(sizeof(char *));
  char **arg2 = malloc(sizeof(char *)*2);
  char **arg3 = malloc(sizeof(char *)*2);
  char **arg4 = malloc(sizeof(char *)*4);

  arg1[0] = malloc(sizeof(char) * 5);
  strcpy(arg1[0], "time");

  arg2[0] = malloc(sizeof(char) * 5);
  strcpy(arg2[0], "time");
  arg2[1] = malloc(sizeof(char) * 4);
  strcpy(arg2[1], "abc"); 

  arg3[0] = malloc(sizeof(char) * 5);
  strcpy(arg3[0], "time");
  arg3[1] = malloc(sizeof(char) * 5);
  strcpy(arg3[1], "date");

  arg4[0] = malloc(sizeof(char) * 5);
  strcpy(arg4[0], "time");
  arg4[1] = malloc(sizeof(char) * 5);
  strcpy(arg4[1], "time");
  arg4[2] = malloc(sizeof(char) * 5);
  strcpy(arg4[2], "echo");
  arg4[3] = malloc(sizeof(char) * 6);
  strcpy(arg4[3], "\"abc\"");
 
  printf(1, "\n----------\nRunning Time Test\n----------\n");
  printf(1, "You will need to verify these tests passed\n");

  printf(1,"\n%s\n", arg1[0]);
  testtimewitharg(arg1);
  printf(1,"\n%s %s\n", arg2[0], arg2[1]);
  testtimewitharg(arg2);
  printf(1,"\n%s %s\n", arg3[0], arg3[1]);
  testtimewitharg(arg3);
  printf(1,"\n%s %s %s %s\n", arg4[0], arg4[1], arg4[2], arg4[3]);
  testtimewitharg(arg4);

  free(arg1[0]);
  free(arg1);
  free(arg2[0]); free(arg2[1]);
  free(arg2);
  free(arg3[0]); free(arg3[1]);
  free(arg3);
  free(arg4[0]); free(arg4[1]); free(arg4[2]); free(arg4[3]);
  free(arg4);
}
#endif

int
main(int argc, char *argv[])
{
  #ifdef CPUTIME_TEST
  testcputime(argv[0]);
  #endif
  #ifdef UIDGIDPPID_TEST
  testuidgid();
  testuidgidinheritance();
  testppid();
  #endif
  #ifdef GETPROCS_TEST
  testgetprocs(argv[0]);
  #endif
  #ifdef TIME_TEST
  testtime();
  #endif
  printf(1, "\n** End of Tests **\n");
  exit();
}
#endif
