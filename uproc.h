struct uproc {
    uint pid;
    uint uid;
    uint gid;
    uint ppid;
    uint elapsed;
    uint cpu_ticks_total;
    char state[10];
    uint sz;
    char name[16];
};
