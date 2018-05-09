#ifdef CS333_P2
#define STRMAX 32

struct uproc {
    uint pid;
    uint uid;
    uint gid;
    uint ppid;
    uint elapsed;
    uint cpu_ticks_total;
    char state[STRMAX];
    uint sz;
    char name[STRMAX];
    #ifdef CS333_P3P4
    uint priority;
    #endif
};
#endif
